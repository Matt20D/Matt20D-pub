# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, val=0, next=None):
#         self.val = val
#         self.next = next
class Solution:
    def removeNthFromEnd(self, head: Optional[ListNode], n: int) -> Optional[ListNode]:
        
        slow = None
        fast = head
        # fast will be n steps further
        while n > 0:
            if fast.next == None:
                return head.next
            fast = fast.next
            n -= 1
        
        slow = head
        while fast != None and fast.next != None:
            slow = slow.next
            fast = fast.next
        
        slow.next = slow.next.next
        return head
