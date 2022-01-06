class Solution:
    def tictactoe(self, moves: List[List[int]]) -> str:

        mv = {"A": {}, "B": {}}
        
        player = "A"
        for idx in range(0, len(moves)):
            move = moves[idx]
            i = move[0]
            j = move[1]
            
            # make move
            if "r" + str(i) not in mv[player].keys():
                mv[player]["r" + str(i)] = 1
            else:
                mv[player]["r" + str(i)] += 1
            
            if mv[player]["r" + str(i)] == 3:
                return player
            
            if "c" + str(j) not in mv[player].keys():
                mv[player]["c" + str(j)] = 1
            else:
                mv[player]["c" + str(j)] += 1
            
            if mv[player]["c" + str(j)] == 3:
                return player
             
            if i + j == 2:
                if "ad" not in mv[player].keys():
                    mv[player]["ad"] = 1
                else:
                    mv[player]["ad"] += 1
                if mv[player]["ad"] == 3:
                    return player
            
            if i == j:
                if "d" not in mv[player].keys():
                    mv[player]["d"] = 1
                else:
                    mv[player]["d"] += 1           
                if mv[player]["d"] == 3:
                    return player
            
            if player == "A":
                player = "B"
            else:
                player = "A"
                
        if len(moves) == 9:
            return "Draw"
        else:
            return "Pending"
