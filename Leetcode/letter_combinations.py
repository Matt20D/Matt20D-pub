class Solution:
    def letterCombinations(self, digits: str) -> List[str]:
        
        num_length = len(digits)
        if not num_length:
            return []
        
        num_vals = {
            '2': ['a', 'b', 'c'],
            '3': ['d', 'e', 'f'],
            '4': ['g', 'h', 'i'],
            '5': ['j', 'k', 'l'],
            '6': ['m', 'n', 'o'],
            '7': ['p', 'q', 'r', 's'],
            '8': ['t', 'u', 'v'],
            '9': ['w', 'x', 'y', 'z']
        }
        temp = [ele for ele in num_vals[digits[0]]]
            
        for i in range(1,num_length):
            l=len(temp) 
            for j in range(l):
                c=temp.pop(0)
                for ele in num_vals[digits[i]]:
                    temp.append(c+ele)
        return temp
