final = 20;


v010 = GAP(:, 1:final);
v000 = NOI(:, 1:final);
v100 = KOR(:, 1:final);
v001 = KOV(:, 1:final);

% 
% figure,plot(1:100,median(v000(1:100,:)./repmat(mean(v000(1:50,:)),100,1),2),'k')
% hold on,plot(1:100,median(v100(1:100,:)./repmat(mean(v100(1:50,:)),100,1),2),'b')
% hold on,plot(1:100,median(v001(1:100,:)./repmat(mean(v001(1:50,:)),100,1),2),'r')
% hold on,plot(1:100,median(v010(1:100,:)./repmat(mean(v010(1:50,:)),100,1),2),'g')

figure,plot(median(KOV,2)/mean(median(KOV(1:50,:),2)))
hold on,plot(median(KOR,2)/mean(median(KOR(1:50,:),2)),'r')
hold on,plot(median(GAP,2)/mean(median(GAP(1:50,:),2)),'k')
hold on,plot(median(NOI,2)/mean(median(NOI(1:50,:),2)),'g')