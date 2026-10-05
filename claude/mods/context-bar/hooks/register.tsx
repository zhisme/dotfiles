import { atom, read, update } from 'claude-code'
import type { Register, SessionRateLimit } from 'claude-code'

import type { FiveHour } from '../types'

const fiveHour = atom({ plugin: 'context-bar', key: 'fiveHour' } as const, null)
const isVisible = atom({ plugin: 'context-bar', key: 'isVisible' } as const, true)

const BAR_CELLS = 40

type Rgb = [number, number, number]

const STOPS: { at: number; rgb: Rgb }[] = [
  { at: 0, rgb: [46, 160, 67] },
  { at: 25, rgb: [46, 160, 67] },
  { at: 45, rgb: [205, 180, 45] },
  { at: 65, rgb: [230, 130, 30] },
  { at: 80, rgb: [210, 45, 40] },
  { at: 100, rgb: [120, 50, 20] },
]

function colorAt(percent: number): string {
  const p = Math.max(0, Math.min(100, percent))
  let lo = STOPS[0]!
  for (const hi of STOPS) {
    if (p <= hi.at) {
      const t = hi.at === lo.at ? 0 : (p - lo.at) / (hi.at - lo.at)
      const rgb = lo.rgb.map((c, k) => Math.round(c + (hi.rgb[k]! - c) * t))
      return '#' + rgb.map(c => c.toString(16).padStart(2, '0')).join('')
    }
    lo = hi
  }
  return '#783214'
}

function pickFiveHour(limits: SessionRateLimit[]): FiveHour | null {
  const found = limits.find(l => l.kind === 'five_hour')
  if (!found) return null
  return { percentUsed: found.percentUsed, resetsAt: found.resetsAt ?? null }
}

function formatReset(resetsAt: string | null): string {
  if (!resetsAt) return ''
  const at = new Date(resetsAt)
  if (Number.isNaN(at.getTime())) return ''
  const hh = String(at.getHours()).padStart(2, '0')
  const mm = String(at.getMinutes()).padStart(2, '0')
  return ` . R at ${hh}:${mm}`
}

export const register: Register = on => {
  on('session.start', async ($, e, next) => {
    await $.command.register({
      name: 'context-bar',
      description: 'Toggle the five-hour usage bar above the prompt',
    })
    const usage = await $.session.usage()
    const found = pickFiveHour(usage.rateLimits)
    if (found) await update($, fiveHour, () => found)

    return next(e)
  })

  on('session.measure', async ($, e, next) => {
    const found = pickFiveHour(e.rateLimits)
    if (found) await update($, fiveHour, () => found)

    return next(e)
  })

  on('command.run', { command: 'context-bar' }, async $ => {
    const shown = await update($, isVisible, v => !v)

    return { text: shown ? 'Five-hour usage bar shown' : 'Five-hour usage bar hidden' }
  })

  on('ui.render', { component: 'AbovePrompt' }, async ($, e, next) => {
    const window = await read($, fiveHour)
    const isQuiet = e.props.hasSurvey || window === null || !(await read($, isVisible))
    if (isQuiet) return next(e)

    const { Box, Text } = $.ui.resolve(e)
    const label = ` ${window.percentUsed}%${formatReset(window.resetsAt)}`
    const cells = Math.max(10, Math.min(BAR_CELLS, e.props.bodyColumns - label.length - 1))
    const filled = Math.round((Math.min(100, window.percentUsed) / 100) * cells)

    const bar = []
    for (let i = 0; i < cells; i++) {
      const at = ((i + 0.5) / cells) * 100
      bar.push(
        i < filled
          ? <Text key={`c${i}`} color={colorAt(at)}>█</Text>
          : <Text key={`c${i}`} dimColor>░</Text>,
      )
    }

    return (
      <Box flexDirection="row">
        {bar}
        <Text color={colorAt(window.percentUsed)}>{label}</Text>
      </Box>
    )
  })
}
