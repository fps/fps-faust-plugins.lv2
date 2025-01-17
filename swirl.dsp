import("stdfaust.lib");

n_swirls = 5;

process =
    (_, _)
  <:
    par(i, n_swirls, signal(i))
  :>
    (_, _)
  with
  {
    signal(n) = sp.stereoize(filtered) : sp.constantPowerPan(0.5 * pan_lfo + 0.5)
    with
    {
      filter_freq = max(20, center_freq + lfo_amplitude * lfo1);
      lfo1 = os.oscp(lfo_freq, 2*pi*n/n_swirls);
      pan_lfo = width * os.oscp(lfo_freq, (2*pi*n/n_swirls) + pi/2);
      filtered = 
        fi.svf.hp(max(50, filter_freq - bandwidth/2), highpass_q) 
        : 
        fi.svf.lp(max(50, filter_freq + bandwidth/2), lowpass_q);
    };

    highpass_q = hslider("[0]Highpass Q", 1, 0.707, 10, 0.01);
    lowpass_q = hslider("[0]Lowpass Q", 1, 0.707, 10, 0.01);
    lfo_freq = hslider("[1]LFO Freq.", 0.2, -20, 20, 0.01);
    low_freq = max(50, hslider("[2]Low Frequency", 100, 1, 16000, 1));
    high_freq = max(50, hslider("[3]High Frequency", 5000, 1, 16000, 1));
    center_freq = (high_freq + low_freq)/2;
    lfo_amplitude = center_freq - low_freq;
    bandwidth = hslider("[4]Bandwidth", 1000, 50, 10000, 1);
    pi = 3.1416;
    width = hslider("[5]Width", 1, 0, 1, 0.001);
  };

