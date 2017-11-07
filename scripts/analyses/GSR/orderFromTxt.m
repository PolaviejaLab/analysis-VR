function [ordered] = orderFromTxt (matNoOrder)

nParticipants = size(matNoOrder, 1);

static = matNoOrder(:, 1:2);

static(static == 0) = 1;
static(static == 100) = 2;

dynamic = matNoOrder(:, 4:8);

dynamic(dynamic == 1) = 4;
dynamic(dynamic == 101) = 5;
dynamic(dynamic == 11) = 8;
dynamic(dynamic == 0) = 6;
dynamic(dynamic == 1001) = 7;

habituation = ones(nParticipants, 1) * 3;

ordered = [static, habituation, dynamic];







end