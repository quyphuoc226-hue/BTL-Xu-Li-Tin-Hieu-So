% Định nghĩa các tham số
Fs1 = 1000;      
Fs2 = 2000;     
Fp1 = 800;      
Fp2 = 2200;    
F = 8000;       
k = 0:50;       
w1 = 0.7 * pi; 
w2 = 0.2 * pi;  
x = 1.5 * cos(w1 * k) + 2 * cos(w2 * k); 
Rp = 0.5;
Rs = 40;
% Chuyển đổi tần số từ Hz sang tần số góc
wp1 = 2 * Fp1 / F; 
wp2 = 2 * Fp2 / F; 
ws1 = 2 * Fs1 / F; 
ws2 = 2 * Fs2 / F; 

Wp = [wp1 wp2]; 
Ws = [ws1 ws2]; 

% Xác định độ dải và tần số cắt
[N, Wn] = cheb2ord(Wp, Ws, Rp, Rs); 
[b, a] = cheby2(N, Rs, Wn, 'stop'); 

% Tính toán đáp ứng tần số
[h, omega] = freqz(b, a, 256); 
z = filter(b, a, x);  % Lọc tín hiệu đầu vào

% Vẽ đồ thị
subplot(4,1,1);
y = 20 * log10(abs(h));
plot(omega/pi, y); grid on;
xlabel('\omega/\pi');
ylabel('Biến đổi, dB');
title('Đáp ứng biên độ - Tần số lọc Chebyshev 2');

subplot(4,1,2);
plot(omega/pi, angle(h) * 180/pi);  
grid on;
xlabel('\omega/\pi');
ylabel('Pha, độ');
title('Đáp ứng pha - Tần số lọc Chebyshev 2');

subplot(4,1,3);
stem(k, x);
grid on;
axis([0 50 -4 4]);
title('Tín hiệu đầu vào');
xlabel('Thời gian n');
ylabel('Biến đổi');

subplot(4,1,4);
stem(k, z);
grid on;
axis([0 50 -4 4]);
title('Tín hiệu đầu ra');
xlabel('Thời gian n');
ylabel('Biến đổi');