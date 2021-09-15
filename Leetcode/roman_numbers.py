class Solution:
    def intToRoman(self, num: int) -> str:
        
        answer = ""
        
        romans = {}
        romans[4] = 'IV'
        romans[9] = 'IX'
        romans[40] = 'XL'
        romans[90] = 'XC'
        romans[400] = 'CD'
        romans[900] = 'CM'
           
        romans[1] = 'I'
        romans[5] = 'V'
        romans[10] = 'X'
        romans[50] = 'L'
        romans[100] = 'C'
        romans[500] = 'D'
        romans[1000] = 'M'
        
        # if x is one of the exceptions
        if num in romans.keys():
            answer += romans.get(num)
            return answer
        
        # sort the denominations
        denominations = sorted(romans.keys(), reverse = True)
        
        while num > 0:

            if len(denominations) > 0 and num - denominations[0] < 0:
                del denominations[0]
            
            else:
                answer += romans[denominations[0]]
                num -= denominations[0]

        
        return answer
