import("stdfaust.lib");

n_swirls = 3;

process =
    _ // no.noise
  <:
    par(i, n_swirls, signal(i))
  :>
    _, _
  with
  {
    signal(n) = fi.svf.bp(center_freq1, q) : sp.panner(0.5 * lfo2 + 0.5)
    with
    {
      center_freq1 = max(20, lfo_center + lfo_amplitude * lfo1);
      lfo1 = (n / n_swirls) * os.oscp(lfo_freq, 2*pi*n/n_swirls);
      lfo2 = os.oscp(lfo_freq, (2*pi*n/n_swirls) + pi/2);
    };

    q = hslider("[0]Q", 10, 0.1, 50, 0.01);
    lfo_freq = hslider("[1]LFO Freq.", 0.1, 0.01, 20, 0.01);
    lfo_center = hslider("[2]LFO Center Frequency", 1000, 100, 8000, 1);
    lfo_amplitude = hslider("[2]LFO Amplitude", 900, 100, 8000, 1);

    pi = 3.1416;
  };
