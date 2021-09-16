class Solution:
    def generateParenthesis(self, n: int) -> List[str]:
        
        # init variables
        open_parens  = "("
        close_parens = ")"
        
        temp = ""
        strs = set() # will hold a set of ALL strings, even bad ones
        stack = list() # will push and pop strings off of here
        stack.append(temp) # init the list
        
        # let's create all possible permutations
        # do a DFS, by going through every possible permutation
        while len(stack) > 0:
            
            # pop the string off the stack
            temp = stack.pop()
            
            # if the length is reached add to set
            if len(temp) == n*2:
                strs.add(temp)
            
            # else, lets add an open and close parens to the end
            # as 2 new children.
            else:
                temp_1 = temp
                temp_2 = temp
                temp_1 += open_parens
                temp_2 += close_parens
                stack.append(temp_1)
                stack.append(temp_2)
        
        # then iterate through them by using a stack, to pop and match them
        def is_valid(x:str) -> bool:
            stack = list()
            
            for i in range(0, len(x)):
                if x[i] == "(":
                    stack.append(open_parens)
                if x[i] == ")":
                    if len(stack) == 0:
                        return False
                    stack.pop() # we are guaranteed that it is an open parens
                                # if it is in stack, by problem definition
            
            # all of the symbols have been matched and popped.
            if len(stack) == 0:
                return True
            
            # non empty stack
            return False
        
        solution = []
        
        # if solution is valid, append to solution
        for string in strs:
            
            if is_valid(string) == True:
                solution.append(string)
        
        return solution
