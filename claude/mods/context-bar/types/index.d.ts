export type FiveHour = { percentUsed: number; resetsAt: string | null }

declare module 'claude-code' {
  interface PluginState {
    'context-bar': { fiveHour: FiveHour | null; isVisible: boolean }
  }
}
