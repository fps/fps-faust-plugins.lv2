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
        hslider("[%n][00] Stage %n - Low - Cutoff", 150, 1, 400, 0.01),
        hslider("[%n][01] Stage %n - Low - Q", 0.7071, 0.1, 5, 0.01),
        hslider("[%n][02] Stage %n - Low - Gain", 0, -32, 32, 0.1)
      )
    : fi.svf.bell(
        hslider("[%n][03] Stage %n - Band 1 - Center", 500, 200, 3000, 0.01),
        hslider("[%n][04] Stage %n - Band 1 - Q", 0.7071, 0.1, 5, 0.01),
        hslider("[%n][05] Stage %n - Band 1 - Gain", 0, -32, 32, 0.1)
      )
    : fi.svf.bell(
        hslider("[%n][06] Stage %n - Band 2 - Center", 800, 200, 3000, 0.01),
        hslider("[%n][07] Stage %n - Band 2 - Q", 0.7071, 0.1, 5, 0.01),
        hslider("[%n][08] Stage %n - Band 2 - Gain", 0, -32, 32, 0.1)
      )
    : fi.svf.hs(
        hslider("[%n][09] Stage %n - High - Cutoff", 2000, 500, 5000, 0.01),
        hslider("[%n][10] Stage %n - High - Q", 0.7071, 0.1, 5, 0.01),
        hslider("[%n][11] Stage %n - High - Gain", 0, -32, 32, 0.1)
      )
    * (
          hslider("[%n][12] Stage %n - Gain", 0, -32, 64, 0.01)
        : ba.db2linear
      )
    : aa.tanh1;
};

