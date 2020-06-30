function [results] = ownership_sociodem (ownership, sociodem)


% gaming habits

non_regular = [sociodem.gaming.usuallyNot; sociodem.gaming.seldom];
regular = [sociodem.gaming.month; sociodem.gaming.week; sociodem.gaming.day];

[a, b, c] = ranksum (ownership(non_regular), ownership(regular));



end