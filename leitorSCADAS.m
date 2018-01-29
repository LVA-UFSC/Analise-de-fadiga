clear all
close all
clc
warning off

%% EDITAR AQUI
% Número de trechos
nTrechos = 10;

% Número de médias por trecho
nMedias = 10;

% Nome do arquivo com dados do acelerometro
load('Testecimentos_GC_sg_8_acelerometro.mat')

% Nome do arquivo com dados do vibrometro
load('Testecimentos_GC_sg_8_vibrometro.mat')

%%
acel = itaAudio(n_Acelerometro.y_values.values',20480,'time');
vibr = itaAudio(n_Vibrometro.y_values.values',20480,'time');


durSig = length(acel.time);



Fs =20480;
L = ceil((durSig/nTrechos)/nMedias);
N = ceil(L/2);

figure(1)
for iTrecho = 1:nTrechos

y_t = vibr.time(ceil(1+(iTrecho-1)*durSig/nTrechos):ceil((iTrecho)*durSig/nTrechos));

x_t = acel.time(ceil(1+(iTrecho-1)*durSig/nTrechos):ceil((iTrecho)*durSig/nTrechos));
% tipos de janelas

janela = 0.5 - 0.5*(cos((0:L-1)'*2*pi/(L-1)));

    
    [Gxx_welch,f] = cpsd(x_t ,x_t ,janela,L/2,N,Fs);
    Gxy_welch = cpsd(y_t,x_t ,janela,L/2,N,Fs);
    H1_welch{:} = abs(Gxy_welch./Gxx_welch./Fs);

% subplot(3,1,i)
semilogy(f,abs(H1_welch{:}),'LineWidth',2,'DisplayName',sprintf('Trecho %.0f',iTrecho));
xlim([10 10240])
xlabel('Frequência [Hz]')
ylabel('Magnitude [m]')
hold all
legend('off')
legend('show')
end

%legend(sprintf('Trecho %.0f',iTrecho))





