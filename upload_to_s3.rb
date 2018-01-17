##################################################
# This script can be used to upload a file into your s3 bucket
# Also includes the command to download the file from s3 into the machine
##################################################

require 'aws-sdk'

s3 = Aws::S3::Resource.new(region: "region_name", credentials: Aws::Credentials.new("access_key_id", "secret_access_key"))
obj = s3.bucket('name_of_the_bucket').object("file_name_to_save_in_bucket")
obj.upload_file("local_file_path")

# command to download
obj.download_file("local_file_path")
