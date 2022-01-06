class Solution:
    def removeElement(self, nums: List[int], val: int) -> int:

        i = 0 # will be the index where we put the value
        for j in range(0, len(nums)):
            if nums[j] != val:
                nums[i] = nums[j]
                i += 1
        return i
 
 class Solution:
    def removeDuplicates(self, nums: List[int]) -> int:
        i = 0
        if len(nums) == 0:
            return 0
        for j in range(1, len(nums)):
            if (nums[j] != nums[i]):
                i += 1
                nums[i]= nums[j]
        return i+1
