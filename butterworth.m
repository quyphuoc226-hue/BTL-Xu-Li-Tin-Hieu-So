Fs1= 1000;
Fs2=2000;
Fp1=800;
Fp2 =2200;
F = 8000;
q=2*4000/8000;
k = 0:50;
w1=0.7 * pi;
w2 = 0.2 * pi;
x = 1.5 * cos(w1 * k) + 2 * cos(w2 * k);
Rp = 0.5;
Rs=40;
% Chuyển đổi tần số
wp1 = 2 * Fp1/F;
wp2 = 2 * Fp2/F;
ws1 = 2 * Fs1/F;
ws2 = 2 * Fs2/F;

Wp = [wp1 wp2]; 
Ws = [ws1 ws2]; 

% Xác định bậc và tần số cắt 
[N, Wn] = buttord(Wp, Ws, Rp, Rs);
[b, a] = butter(N, Wn, 'stop');    % thiết kế bộ lọc dải chắn

% Tính toán đáp ứng tần số 
[h,omega]= freqz(b,a,256);
z = filter(b, a, x);        % Lọc tín hiệu đầu vào
% Vẽ đồ thị
subplot(4,1,1);
y = 20*log10(abs(h));
plot(omega/pi,y); grid on;
xlabel('\omega/\pi');
ylabel('Bien do,dB');
title('Dap ung bien do-tan so Mach loc chan dai butter  ');

subplot(4,1,2);
plot(omega/pi,angle(h)); grid on;
xlabel('\omega/\pi');
ylabel('phase,radian');
title('Dap ung pha-tan so Mach loc chan dai butter  ');

subplot(4,1,3);
stem(k,x);
grid on;
axis([0 50 -4 4])
title('tin hieu dau vao');
xlabel('thoi gian n');
ylabel('bien doi');

subplot(4,1,4)
stem(k,z);
grid on;
axis([0 50 -4 4])
title('tin hieu dau ra');
xlabel('thoi gian n');
ylabel('bien doi');