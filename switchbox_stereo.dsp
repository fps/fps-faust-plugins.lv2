import("stdfaust.lib");

process = (_, _) <: ((_ * (1 - slider)), (_ * (1 - slider)), (_ * slider) , (_ * slider))
with {
    slider = hslider("Channel", 0, 0, 1, 0.001);
};

