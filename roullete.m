function [Earnings] = roullete(money)
% developed by Jason Foster, jf727@nau.edu, March 2019.
% simulates game to help determine the optimal betting strategy.

starting_money = money;
current_bet = money/160;
bet = current_bet/2;
playing = true;
while(playing)
    money = money - current_bet;
    if money <= 0
        playing = false;
    end
    roll = randi(37);
    if roll > 13
        money = money + current_bet + bet;
        if money > starting_money
            playing = false;
        end
    end
end

Earnings = money;
return

end