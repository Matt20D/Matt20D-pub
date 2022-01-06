# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, val=0, next=None):
#         self.val = val
#         self.next = next
class Solution:
    def numComponents(self, head: Optional[ListNode], nums: List[int]) -> int:
        
        prev = None
        curr = head
        num_set = set(nums)
        answer = 0
        while curr:
            #print(curr.val)
            #print(curr.val in num_set)
            if curr.val in num_set:
                if prev is not None:
                    num_set.remove(prev.val)
                    num_set.remove(curr.val)
                    answer += 1
                    prev = curr
                    curr = curr.next
                else:
                    if curr.next == None:
                        num_set.remove(curr.val)
                        answer += 1  
                    else:
                        if curr.next.val not in num_set:
                            num_set.remove(curr.val)
                            answer += 1
                    #prev = curr
                    curr = curr.next
                    
            else:
                prev = None
                curr = curr.next
        return answer
