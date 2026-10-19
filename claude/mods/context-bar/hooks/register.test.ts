import { expect, mock, test } from 'claude-code/testing'
import type { Engine } from 'claude-code/testing'
import type { On } from 'claude-code'
import type { SessionMeasureInput, SessionRateLimit } from 'claude-code'

const PROPS = {
  hasSurvey: false,
  isWorking: false,
  maxRows: 10,
  bodyColumns: 80,
  scroll: { offset: 0, bodyRows: 9 },
  view: {},
}

const NOW = Date.parse('2026-10-05T12:00:00Z')

const engine = (on: On) => {
  mock.clock(on, { now: NOW })
  on('session.measure', (_$, e) => ({ changed: e.changed }))
  on('ui.render', { component: 'AbovePrompt' }, () => ({ type: 'Box', props: { key: 'engine' }, children: [] }) as never)
}

const measure = ($: Engine, rateLimits: SessionRateLimit[]) =>
  $.session.measure({
    context: { window: 200000 },
    rateLimits,
    changed: ['rateLimits'],
  } as unknown as SessionMeasureInput)

const runCommand = ($: Engine) =>
  $.command.run({
    command: 'context-bar',
    args: '',
    origin: { isUser: true },
    presentation: { isFullscreen: false },
  } as never)

const mountBand = ($: Engine, surface: 'terminal' | 'desktop', props = PROPS) =>
  $.ui.mount({ plugin: 'context-bar', surface, component: 'AbovePrompt', props })

test('draws only the five-hour window with its percent', async ($, on) => {
  engine(on)
  await measure($, [
    { kind: 'seven_day', percentUsed: 88 },
    { kind: 'five_hour', percentUsed: 42 },
  ])
  for (const surface of ['terminal', 'desktop'] as const) {
    const ui = await mountBand($, surface)
    expect(await ui.find({ type: 'Text', text: / 42%/ })).toBeDefined()
    expect(await ui.find({ type: 'Text', text: /88/ })).toBeUndefined()
    await ui.unmount()
  }
})

test('colors filled cells green at the low end and brownish-red at the top', async ($, on) => {
  engine(on)
  await measure($, [{ kind: 'five_hour', percentUsed: 100 }])
  const ui = await mountBand($, 'terminal')
  const cells = await ui.findAll({ type: 'Text', text: '█' })
  expect(cells.length).toBe(40)
  expect(cells[0]?.props.color).toBe('#2ea043')
  expect(cells[cells.length - 1]?.props.color).not.toBe('#2ea043')
  const last = String(cells[cells.length - 1]?.props.color)
  const red = parseInt(last.slice(1, 3), 16)
  const green = parseInt(last.slice(3, 5), 16)
  expect(red > green * 2).toBe(true)
  expect(red < 160).toBe(true)
  await ui.unmount()
})

test('zero percent draws no filled cells', async ($, on) => {
  engine(on)
  await measure($, [{ kind: 'five_hour', percentUsed: 0 }])
  const ui = await mountBand($, 'terminal')
  expect((await ui.findAll({ type: 'Text', text: '█' })).length).toBe(0)
  expect((await ui.findAll({ type: 'Text', text: '░' })).length).toBe(40)
  await ui.unmount()
})

test('over 100 percent caps the bar at full', async ($, on) => {
  engine(on)
  await measure($, [{ kind: 'five_hour', percentUsed: 130 }])
  const ui = await mountBand($, 'terminal')
  expect((await ui.findAll({ type: 'Text', text: '█' })).length).toBe(40)
  await ui.unmount()
})

test('narrow terminal shrinks the bar but keeps at least ten cells', async ($, on) => {
  engine(on)
  await measure($, [{ kind: 'five_hour', percentUsed: 50 }])
  const ui = await mountBand($, 'terminal', { ...PROPS, bodyColumns: 12 })
  const all = [
    ...(await ui.findAll({ type: 'Text', text: '█' })),
    ...(await ui.findAll({ type: 'Text', text: '░' })),
  ]
  expect(all.length).toBe(10)
  await ui.unmount()
})

test('draws nothing without a five-hour reading', async ($, on) => {
  engine(on)
  await measure($, [{ kind: 'seven_day', percentUsed: 50 }])
  const ui = await mountBand($, 'terminal')
  expect(await ui.find({ type: 'Text', text: /%/ })).toBeUndefined()
  await ui.unmount()
})

test('keeps the band drawn by the next mod in the slot while the bar is visible', async ($, on) => {
  engine(on)
  await measure($, [{ kind: 'five_hour', percentUsed: 30 }])
  const ui = await mountBand($, 'terminal')
  expect(await ui.find({ type: 'Text', text: / 30%/ })).toBeDefined()
  expect(await ui.find({ key: 'engine' })).toBeDefined()
  await ui.unmount()
})

test('still draws the bar when nothing answers beneath', async ($, on) => {
  mock.clock(on, { now: NOW })
  on('session.measure', (_$, e) => ({ changed: e.changed }))
  await measure($, [{ kind: 'five_hour', percentUsed: 30 }])
  const ui = await mountBand($, 'terminal')
  expect(await ui.find({ type: 'Text', text: / 30%/ })).toBeDefined()
  await ui.unmount()
})

test('yields to a survey', async ($, on) => {
  engine(on)
  await measure($, [{ kind: 'five_hour', percentUsed: 30 }])
  const ui = await mountBand($, 'terminal', { ...PROPS, hasSurvey: true })
  expect(await ui.find({ type: 'Text', text: /%/ })).toBeUndefined()
  await ui.unmount()
})

test('/context-bar toggles the band off and back on', async ($, on) => {
  engine(on)
  await measure($, [{ kind: 'five_hour', percentUsed: 30 }])

  const hidden = await runCommand($)
  expect(hidden.text).toMatch(/hidden/)
  let ui = await mountBand($, 'terminal')
  expect(await ui.find({ type: 'Text', text: /%/ })).toBeUndefined()
  await ui.unmount()

  const shown = await runCommand($)
  expect(shown.text).toMatch(/shown/)
  ui = await mountBand($, 'terminal')
  expect(await ui.find({ type: 'Text', text: / 30%/ })).toBeDefined()
  await ui.unmount()
})

test('shows percent and local reset clock time', async ($, on) => {
  engine(on)
  const resetsAt = '2026-10-05T14:02:00Z'
  const at = new Date(resetsAt)
  const hhmm = `${String(at.getHours()).padStart(2, '0')}:${String(at.getMinutes()).padStart(2, '0')}`
  await measure($, [{ kind: 'five_hour', percentUsed: 7, resetsAt }])
  const ui = await mountBand($, 'terminal')
  expect((await ui.find({ type: 'Text', text: /%/ }))?.text).toBe(` 7% . R at ${hhmm}`)
  await ui.unmount()
})

test('shows only percent without a reset time', async ($, on) => {
  engine(on)
  await measure($, [{ kind: 'five_hour', percentUsed: 12 }])
  const ui = await mountBand($, 'terminal')
  expect((await ui.find({ type: 'Text', text: /%/ }))?.text).toBe(' 12%')
  await ui.unmount()
})

test('shows only percent when reset time is malformed', async ($, on) => {
  engine(on)
  await measure($, [{ kind: 'five_hour', percentUsed: 12, resetsAt: 'soon' }])
  const ui = await mountBand($, 'terminal')
  expect((await ui.find({ type: 'Text', text: /%/ }))?.text).toBe(' 12%')
  await ui.unmount()
})

const rgbOf = (hex: unknown) => {
  const s = String(hex)
  return [1, 3, 5].map(i => parseInt(s.slice(i, i + 2), 16))
}

const lastFilledColor = async ($: Engine, percentUsed: number) => {
  await measure($, [{ kind: 'five_hour', percentUsed }])
  const ui = await mountBand($, 'terminal')
  const cells = await ui.findAll({ type: 'Text', text: '█' })
  await ui.unmount()
  return rgbOf(cells[cells.length - 1]?.props.color)
}

test('stays green up to a quarter of the window', async ($, on) => {
  engine(on)
  expect(await lastFilledColor($, 25)).toEqual([46, 160, 67])
})

test('is not red at 40 or 56 percent', async ($, on) => {
  engine(on)
  for (const p of [40, 56]) {
    const [r, g] = await lastFilledColor($, p)
    expect(g! > 120).toBe(true)
    expect(r! > 150).toBe(true)
  }
})

test('is orange around 65 percent', async ($, on) => {
  engine(on)
  const [r, g, b] = await lastFilledColor($, 65)
  expect(r! > 200).toBe(true)
  expect(g! > 100 && g! < 160).toBe(true)
  expect(b! < 60).toBe(true)
})

test('is red at 80 percent', async ($, on) => {
  engine(on)
  const [r, g] = await lastFilledColor($, 80)
  expect(r! > 180).toBe(true)
  expect(g! < 70).toBe(true)
})
