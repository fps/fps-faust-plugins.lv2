/*
  From Optimized velvet-noise decorrelator, Schlecht et. al., Conference: International Conference on Digital Audio Effects (DAFx-18), pp. 87-94At: Aveiro, Portugal
*/
import("stdfaust.lib");
process = 
    (_,_)
    <:
    (
        on_amount * (_ <: sum(i, 30, 0.1*rdtable(gains_1, i) * de.delay(1300, rdtable(delays_1, i)-1))),
        on_amount * (_ <: sum(i, 30, 0.1*rdtable(gains_2, i) * de.delay(1300, rdtable(delays_2, i)-1))),
        (_ * off_amount), 
        (_ * off_amount)
    )
    :> 
    (_,_)
with {
    on_amount = hslider("Amount", 1, 0, 1, 0.001);
    off_amount = (1 - on_amount);

    delays_1 = waveform{1, 46, 91, 134, 175, 182, 239, 271, 351, 359, 407, 484, 531, 536, 581, 651, 669, 731, 797, 829, 851, 890, 961, 984, 1027, 1074, 1130, 1175, 1232, 1246};

    gains_1 = waveform{4.71, 7.37, -3.72, 1.46, 1.12, -1.84, 0.64, -0.54, -0.64, 1.08, -0.32, 0.24, 0.21, -0.49, 0.14, 0.18, -0.14, -0.09, -0.08, -0.08, 0.07, 0.05, 0.04, -0.04, 0.02, 0.02, 0.01, -0.01, 0.01, -0.01};

    delays_2 = waveform{1, 5, 78, 125, 172, 219, 234, 271, 318, 381, 403, 460, 531, 575, 583, 663, 703, 737, 791, 809, 881, 902, 950, 999, 1041, 1083, 1135, 1177, 1216, 1258};
    
    gains_2 = waveform{4.11, -3.91, 5.58, 4.30, -2.96, 2.02, -0.61, -1.34, 1.15, -0.93, 0.81, -0.37, -0.26, 0.16, 0.14, 0.10, -0.19, 0.07, 0.06, 0.05, 0.05, -0.06, -0.04, 0.03, 0.02, -0.02, 0.01, -0.01, -0.01, -0.01};
};
