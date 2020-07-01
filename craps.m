function [Earnings] = craps(bankroll, minuets, starting_bet, bet_limit)
%i only look at betting on dont pass

%lets start our bet
starting_bankroll = bankroll;
playing = true;
current_bet = 0;
push = false;
num_of_pushes = 0;
To_win = 5001;
To_lose = bankroll - bankroll/2;
while(playing)
    if bankroll >= To_win
        playing = false;
        continue
    end
%     if bankroll <= To_lose
%         playing = false;
%         continue
%     end
    if current_bet == 0
        current_bet = starting_bet;
    elseif push
        % place same bet
        push = false;
    else
        current_bet = current_bet*2;
    end
    %are we over the bet limit?
    if current_bet > bet_limit
        current_bet = 0;
        playing = false;
        continue
    end
    %we can afford this bet... R-right?
    if current_bet > bankroll
        playing = false;
        continue
    end
    bankroll = bankroll - current_bet;
    %lets do the come out roll
    dice_1 = randi(6);
    dice_2 = randi(6);
    %did we lose?
    if dice_1 + dice_2 == 7 || dice_1 + dice_2 == 11
        minuets = minuets - 1;
        if minuets == 0
            playing = false;
            continue
        end
        continue
    end
    %did we push?
    if dice_1 + dice_2 == 12
        push = true;
        num_of_pushes = num_of_pushes + 1;
        continue
    end
    %well, did we win?
    if dice_1 + dice_2 == 2 || dice_1 + dice_2 == 3
        bankroll = bankroll + current_bet*2;
        minuets = minuets - 1;
        current_bet = 0;
        if minuets == 0
            playing = false;
            continue
        end
        continue
    end
    %welp, now things get complicated.... so if the roll wasnt 2,3,7,11 or
    %12 then we have established a point
    rolling = true;
    point = dice_1 + dice_2;
    while(rolling)
        dice_1 = randi(6);
        dice_2 = randi(6);
        %So if the point gets rolled i lose
        if dice_1 + dice_2 == point
            minuets = minuets - 1;
            rolling = false;
        if minuets == 0
            playing = false;
            continue
        end
        continue
        end
        %and if a seven got rolled I win
        if dice_1 + dice_2 == 7
            bankroll = bankroll + current_bet*2;
            minuets = minuets - 1;
            current_bet = 0;
            rolling = false;
            if minuets == 0
                playing = false;
                continue
            end
            continue
        end
        %if neither happened, roll again
    end
end
Earnings = bankroll;
return
end