%starting signal%
signal_in = @(t,phi) cos(500*2*pi.*t + phi);
t = 0:.00001:.025-.00001;
phi = 0;
plot(t,signal_in(t,phi))
%now lets translate it%
trans_sig = zeros(1,length(t));
count = -1;
for i = 1:length(t)
    count = count + 1;
    if count == 10
        phi = phi + pi/100;
        count = 0;
    end
    trans_sig(i) = signal_in(t(i),phi);
end
plot(t,trans_sig)
hold on;
plot(t,signal_in(t,0))
xlabel('t');
ylabel('amplitude');
grid on;
legend('translated','untranslated')
axis([0, .02, -1.1, 1.1])

%with input omega%

hold off;
fr = input('enter input signal freq in Hz:  ');
fo = 10105;
ft = fo - fr;
%this is how much shifting i need%
necessary_shift = fr - ft;
time_req = round(10^6/necessary_shift);

phi = 0;
t = 0:.0000001:.025-.0000001;
signal_in = @(t,phi) cos(fr*2*pi.*t + phi);
trans_sig = zeros(1,length(t));
count = -1;
for i = 1:length(t)
    count = count + 1;
    if count == 10
        phi = phi - (2*pi)/time_req;
        count = 0;
    end
    trans_sig(i) = signal_in(t(i),phi);
end
plot(t,trans_sig)
hold on;
plot(t,signal_in(t,0))
xlabel('t');
ylabel('amplitude');
grid on;
legend('translated','untranslated')
axis([0, .002, -1.1, 1.1])