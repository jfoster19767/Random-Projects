#Compute Alex's scenario with different parameters by Jason Foster 10/6/2021

import random
import numpy

#init variables
Number_of_Rolls = [1, 10, 100, 250, 500, 750, 1000, 10000]
Number_of_Universes = 10000000
Deaths = 0
Limbs_Lost = 0
Earnings = 0
#The arrays below will store the stats for the result of each experiment
#Then we can print the info out later
Earnings_Array = numpy.zeros(Number_of_Universes)
Limbs_Lost_Array = numpy.zeros(Number_of_Universes)
Deaths_Array = numpy.zeros(Number_of_Universes)


#how many rolls are we chancing on this bet?
for Rolls in Number_of_Rolls:
    #clean the previous data from the last test
    Earnings_Array = numpy.zeros(Number_of_Universes)
    Limbs_Lost_Array = numpy.zeros(Number_of_Universes)
    Deaths_Array = numpy.zeros(Number_of_Universes)
    #Now we need to simulate many universes where we take our chances and store
    #each universes results in arrays
    for Universe_Number in range(0, Number_of_Universes):
        #How many Rolls are we chancing on this bet?
        Limbs_Lost = 0
        Earnings = 0
        for Roll_Number in range(0, Rolls):
            #Roll the dice
            Roll_Result = random.randint(1,100)
            #Did I win?
            if Roll_Result == 1:
                #I didn't
                Limbs_Lost = Limbs_Lost + 1
                #Did I Die?
                if Limbs_Lost == 5:
                    #I Died and the dead doesn't keep winnings
                    #end this universe
                    Earnings_Array[Universe_Number] = 0
                    Deaths_Array[Universe_Number] = 1 #its boolean but ints are easier to work with imo
                    #we lost 4 limbs yes... but I dont think we should mark this as 4.
                    #instead we will leave this as NULL and remove it latter for more acurate stats
                    Limbs_Lost_Array[Universe_Number] = numpy.nan
                    break
            else:
                #We won
                Earnings = Earnings + 10000
        #This universe has been completed, lets store its stats
        if Deaths_Array[Universe_Number] == 0:
            number = Universe_Number
            Earnings_Array[number] = Earnings
            Limbs_Lost_Array[number] = Limbs_Lost
            Deaths_Array[number] = 0
    #Print out all the results
    print('Average Earnings for doing ' + str(Rolls) + ' roll is ' + str(numpy.mean(Earnings_Array)))
    print('Chance of death is ' + str(numpy.mean(Deaths_Array)))
    count1 = 0
    count2 = 0
    count3 = 0
    count4 = 0
    for j in range(0,Number_of_Universes):
        if Limbs_Lost_Array[j] == 1:
            count1 = count1 + 1
        elif Limbs_Lost_Array[j] == 2:
            count2 = count2 + 1
        elif Limbs_Lost_Array[j] == 3:
            count3 = count3 + 1
        elif Limbs_Lost_Array[j] == 4:
            count4 = count4 + 1
    print('Chance of losing 1 limb is ' + str(count1 / Number_of_Universes))
    print('Chance of losing 2 limb is ' + str(count2 / Number_of_Universes))
    print('Chance of losing 3 limb is ' + str(count3 / Number_of_Universes))
    print('Chance of losing 4 limb is ' + str(count4 / Number_of_Universes))
    
    
