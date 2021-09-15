# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, val=0, next=None):
#         self.val = val
#         self.next = next
class Solution:
    def addTwoNumbers(self, l1: Optional[ListNode], l2: Optional[ListNode]) -> Optional[ListNode]:
        
        l1_list = []
        l2_list = []
        
        curr = l1
        while curr != None:
            l1_list.append(curr.val)
            curr = curr.next
        
        curr = l2
        while curr != None:
            l2_list.append(curr.val)
            curr = curr.next
        
        sum_list = []
      
        if len(l1_list) > len(l2_list):
            temp = len(l1_list) - len(l2_list)
            while temp > 0:
                l2_list.append(0)
                temp -= 1
            
        elif len(l1_list) < len(l2_list):
            temp = len(l2_list) - len(l1_list)
            while temp > 0:
                l1_list.append(0)
                temp -= 1   
        else: # the are equal
            pass
        
        print(l1_list)
        print(l2_list)
        
        # do the addition
        carry = 0
        for i in range(0, len(l1_list)):
                
            if carry > 0:
                node_sum = l1_list[i] + l2_list[i] + carry
                carry = 0
            else:
                node_sum = l1_list[i] + l2_list[i]
                    
            if node_sum >= 10:
                carry = 1
                node_sum -= 10
                    
            sum_list.append(node_sum)
        if carry > 0:
            sum_list.append(carry)
        
        #init the list head
        head = ListNode(sum_list[0], None)
        answer = head
        
        for i in range(1,len(sum_list)):
            val = sum_list[i]
            node = ListNode(val, None)
            head.next = node
            head = node
        
        # terminate the linked list
        head.next = None
        
        return answer
        
