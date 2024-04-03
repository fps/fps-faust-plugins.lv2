import("stdfaust.lib");

nStages = 2;

process =
    seq(i, nStages, oneStage(i))
  * (
        hslider("[3][0] Master - Gain", 0, -32, 32, 0.01)
      : ba.db2linear
    )
with {
  oneStage(n) =
      fi.svf.ls(
        hslider("[%n][0] Stage %n - Low - Cutoff", 150, 1, 400, 0.01),
        0.7071,
        hslider("[%n][1] Stage %n - Low - Gain", 0, -32, 32, 0.1)
      )
    : fi.svf.bell(
        hslider("[%n][3] Stage %n - Mids - Center", 800, 200, 3000, 0.01),
        0.7071,
        hslider("[%n][4] Stage %n - Mids - Gain", 0, -32, 32, 0.1)
      )
    : fi.svf.hs(
        hslider("[%n][5] Stage %n - High - Cutoff", 2000, 500, 5000, 0.01),
        0.7071,
        hslider("[%n][6] Stage %n - High - Gain", 0, -32, 32, 0.1)
      )
    * (
          hslider("[%n][7] Stage %n - Gain", 0, -32, 32, 0.01)
        : ba.db2linear
      )
    : aa.tanh1;
};

