# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, val=0, next=None):
#         self.val = val
#         self.next = next
class Solution:
    def swapPairs(self, head: Optional[ListNode]) -> Optional[ListNode]:
        
        # basecases
        if head == None:
            return head
        if head.next == None:
            return head
        if head.next.next == None:
            left = head
            right = head.next
            
            left.next = right.next
            right.next = left
            
            return right
        
        counter = 0
        
        # initialize the left and right 
        left = head
        right = head.next
        
        # swap
        left.next = right.next
        right.next = left
          
        # keep track of the new head after the swap
        head = right
        splice_node = left

        done = False
        while not done:
            
            # update left and right
            left = splice_node.next
            right = left.next
            
            if left == None or right == None:
                break
                
            # swap the two nodes and splice in previous chain
            splice_node.next = right
            left.next = right.next
            right.next = left
            
            # keep track of the one to the right of the swapped one
            splice_node = left
            
            if splice_node.next == None:
                done = True
        
        return head


