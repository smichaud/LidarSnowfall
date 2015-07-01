% Plot to illustrate the effect of the buidling shielding.
clf
x = 0:0.01:15;
Building = 1-exp(-x);
hl(1) = plot(x,Building,'b--','LineWidth',2);
hold on;
hl(2) = 
