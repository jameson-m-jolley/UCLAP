UCLAP ~ "../lib.ua"

┌─╴test
  # TODO: no assertions here — the tools module (ApplyColor / ANSI colors)
  # has zero test coverage. Add `˙⍤` checks.
  # (noted by opencode/big-pickle)

  UCLAP~Tools~Timer~StartTimer "ParseStandardArrayFmt"
  ˙⍤ ≍ {"2" "2" "2"} UCLAP~Tools~ParseStandardArrayFmt "|2,2,2|"
  UCLAP~Tools~Timer~EndTimerAndRecordTimeDelta

  UCLAP~Tools~Timer~StartTimer "ParseStandardArrayFmt"
  ˙⍤ ≍ {"2" "2" "2"} UCLAP~Tools~ParseStandardArrayFmt "[2,2,2]"
  UCLAP~Tools~Timer~EndTimerAndRecordTimeDelta

  UCLAP~Tools~Timer~StartTimer "ParseStandardArrayFmt"
  ˙⍤ ≍ {"2" "2" "2"} UCLAP~Tools~ParseStandardArrayFmt "{2,2,2}"
  UCLAP~Tools~Timer~EndTimerAndRecordTimeDelta

  UCLAP~Tools~Timer~StartTimer "ParseStandardArrayFmt"
  ˙⍤ ≍ {"2" "2" "2"} UCLAP~Tools~ParseStandardArrayFmt "2,2,2"
  UCLAP~Tools~Timer~EndTimerAndRecordTimeDelta

└─╴
