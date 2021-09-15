class Solution:
    def groupAnagrams(self, strs: List[str]) -> List[List[str]]:
        
        if len(strs) == 0:
            return [[""]]
        elif len(strs) == 1:
            return [[strs[0]]]
        # the list has more than 0 or 1 strings
        else:
            anagrams = {}
            answer = list()
            
            # combine all anagrams that belong to same set of letters
            for i in range(0, len(strs)):
                tmp = strs[i] # string
                chars = set(list(tmp)) # get the chars as a list
                tmp_set_list = sorted(list(chars))
                # count the occurences of a character in a string
                letter_list = []
                for j in tmp_set_list:
                    letter_list.append(tmp.count(j))
                tmp_set_list.append(tuple(letter_list))
                tmp_set_tuple = tuple(tmp_set_list)
                
                if tmp_set_tuple in anagrams.keys():
                    
                    anagrams[tmp_set_tuple].append(strs[i])
                else:
                    
                    anagrams[tmp_set_tuple] = []
                    anagrams[tmp_set_tuple].append(strs[i])
            
            print(anagrams)
            # iterate through all of the keys and return answer
            for key in anagrams.keys():
                answer.append(anagrams[key])
            return answer
