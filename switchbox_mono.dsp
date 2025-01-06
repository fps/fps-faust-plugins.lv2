import("stdfaust.lib");

process = _ <: ((_ * slider) , (_ * (1 - slider)))
with {
    slider = hslider("To output", 0, 0, 1, 0.001);
};

