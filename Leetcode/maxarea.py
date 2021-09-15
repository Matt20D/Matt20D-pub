from heapq import heappop, heappush, heapify

class Solution:
    def maxArea(self, height: List[int]) -> int:
        
        # heapq is a min heap, so I have to adjust accordingly
        # multiply everything by -1 to ensure that we get the
        # largest magnitude smallest number
        heap = []
        heapify(heap)
        
        for i in range(0,len(height)):
            ai = height[i]
            
            #print("j\tdelta\taj\tai\tarea")
            j = i+1
            while j < len(height):
                
                # obvious
                if i == j:
                    j+=1
                    continue
                    
                aj = height[j]
                
                # keep track of the x distance
                delta = abs(i-j)
                
                height_delta = ai - aj
                area = 0

                # cases
                #case when lheight and rheight are equal
                if height_delta == 0:
                    area = ai * delta
                #case when lheight is smaller than rheight
                elif height_delta < 0:
                    area = ai * delta
                #case when lheight is bigger than rheight    
                elif height_delta > 0:
                    area = aj * delta
                
                #print(str(j) + "\t" + str(delta) + "\t" + str(aj) 
                #       + "\t" + str(ai) + "\t" + str(area))
                heappush(heap, -1 * area)
                j+=1
        
        #print("--------")        
        almost_answer = heappop(heap)
        
        # return the actual area
        return -1 * almost_answer

-----------------

Iteration 2

class Solution:
    def maxArea(self, height: List[int]) -> int:
        
        maxarea = 0
        l = 0
        r = len(height) - 1
        
        while l < r:
            area = min(height[l],height[r]) * (r-l)
            maxarea = max(area, maxarea)
            
            if (height[l] < height[r]):
                l += 1
            else:
                r -= 1
        
        return maxarea
            

        
