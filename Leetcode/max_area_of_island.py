class Solution:
    def maxAreaOfIsland(self, grid: List[List[int]]) -> int:
        m = len(grid)
        n = len(grid[0])
        
        # begin with a sentinel value
        max_area = -1 
        visited = set()
        
        def dfs(grid:List[List[int]], i:int, j:int) -> int:
            
            if i < 0 or j < 0:
                return 0
            
            if i >= m or j >= n:
                return 0
            
            if grid[i][j] == 0:
                return 0
            
            if grid[i][j] == 1:
                
                # check if we have visited
                if (i,j) in visited:
                    return 0
                else:
                    visited.add((i,j))
                
                area = 1
                
                up    = dfs(grid, i-1, j)
                right = dfs(grid, i, j+1)
                down  = dfs(grid, i+1, j)
                left  = dfs(grid, i, j-1)
                
                return area + up + right + down + left
        
        for i in range(0, m):
            for j in range(0,n):
                #print(i,j)
                #print(grid[i][j])
                temp = dfs(grid, i, j)
                if temp > max_area:
                    max_area = temp
    
        
        # if there is no island, return 0
        if max_area == -1:
            return 0
        return max_area
