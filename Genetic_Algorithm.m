function [Optimal_Solution] = Genetic_Algorithm(Base_Location, Customer_Array)
% Function developed by Jason Foster, jf727@nau.edu, November 2018.
% To use this function type:
% Optimal_Solution = Genetic_Algorithm(Base_Location, Customer_Array);
% Where Base_Location is a point in 2D space where our children will always
% start from, EX: Base_Location = [12, 15];
% Customer_Array is the points where every customer is located, EX:
% Customer_Array = [1, 1; 2, 2; 3, 3; 4, 4];
% The best way to make a random customer array would be to call 
% Customer_Array = randi(Largest_random_integer, Number_of_Customers, 2);

% It would be cool to see how changing some parameters affect the genetic
% algorithm.
Num_Of_First_Generation_Children = [100];%,25,75,150,250];
Num_Of_Generations = [75];%,25,75,150,250];
Thresholds = [.1,.5];%;.1,.50;.1,.75;.10,.25;.10,.50;.10,.75;.25,.50;.25,.75];
Mutation_Rate = [.2];%, .02, .05, .1, .2];

% First we need to create an initial population. 
[Current_Elite_Population, Current_Average_Population] =...
    Create_First_Generation(Base_Location, Customer_Array, ...
    Num_Of_First_Generation_Children, Thresholds, Mutation_Rate);
for Generation_Number = 1:Num_Of_Generations - 1 
    if(Generation_Number == Num_Of_Generations - 1)
        [Elite_Population, Average_Population] = Next_Generation(Base_Location, Customer_Array,...
            Current_Elite_Population, Current_Average_Population, Thresholds, Mutation_Rate);
    else
        [Current_Elite_Population, Current_Average_Population] = Next_Generation(Base_Location, Customer_Array,...
            Current_Elite_Population, Current_Average_Population, Thresholds, Mutation_Rate);
    end
end

Final_Array_Ave = Average_Population(1:end).Route;
Final_Array_Elite = Elite_Population(1:end).Route;

Final_Array = [Final_Array_Ave; Final_Array_Elite];

Optimal_Solution = Final_Array;

return

%%%            Rules for creating the new generation                    %%%
% We will take in a success threshold in the form of [XX, YY] where XX is
% the top XX percent that are so successful they dont need a partner to
% mate. YY is the top YY-XX percent that will mate with each other having 
% children that will have combinations of both parents. Everyone else dies.
% EX if we had [10, 50] the top 10 percent of children would have children
% identical to them while everyone 11-50 percent have kids that share
% traits of their parents. Everyone below the 50% cutoff mark dies with
% no children.
% Now, how many kids do each couple have? Well I have a few points I need
% to hit
% 1: each couple has the same number of kids(to keep my life simple)
% 2: I need enough children so that my population doesnt die off too quickly
% 3: I need to ensure future generations dont have too many children.
% After some basic calculations it seems that letting each superior child
% have 2 identical babies and each couple from the not so successful group
% have 2 kids is ok in most cases.

end