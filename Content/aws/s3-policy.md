A bucket policy is a JSON format that specifies permissions to access an S3 bucket and its objects.
It controls who can access the bucket and what actions they can perform (read, write, delete, etc.).

## EXAMPLE:

![bucket-policy](/resources/images/bucket-policy.png)


---

- Effect: Allow or Deny.
- Principal: Specifies who the policy applies to (* means everyone).
- Action: The allowed S3 operations (e.g., s3:GetObject for reading objects). in this case - all s3 actions.
- Resource: The S3 bucket or objects the policy applies to.
- Condition: Applies additional checks to the permission.
In that case i allow actions only to those IP addresses.

It is recommended to Use the least privilege principle - Only allow access to what is necessary.
Also, avoid making buckets public unless needed.


** arn refers to Amazon Resource Name and its like the ID of the resource.
   For any resource in AWS there is a unique arn.

