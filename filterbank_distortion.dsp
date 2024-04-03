import("stdfaust.lib");

process =
    fi.filterbank(3, freqs)
  :
    par(i, 13,
        (
            _
          *
            (hslider("[%2i][0] Pre  Gain %2i", 0, -32, 64, 0.01) : ba.db2linear)
        )
      :
        aa.tanh1
      :
        (
            _
          *
            (hslider("[%2i][1] Post Gain %2i", 0, -32, 64, 0.01) : ba.db2linear)
        )
    )
  :>
    _
  with {
    freqs = (
      220,
      311.1269837220809,
      440,
      622.2539674441618,
      880,
      1244.507934888324,
      1760,
      2489.015869776647,
      3520,
      4978.031739553295,
      7040,
      9956.063479106590
    );
  };
