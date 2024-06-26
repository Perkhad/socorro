import json

# Load WLASL dataset
with open('/work/NExT-GPT/data/IT_data/T+X-T_data/videochat/WLASL_v0.3.json') as f:
    wlasl_data = json.load(f)

# Transform WLASL data into video chat instruction data format
instruction_data = []
for entry in wlasl_data:
    gloss = entry['gloss']  # This is the sign language translation
    for instance in entry['instances']:
        # Construct the video file path (assuming direct mapping is possible)
        # You might need to adjust this part based on how your videos are stored
        video_path = f"videos/{instance['video_id']}.mp4"

        # Construct the QA pair
        qa_pair = {
            "q": "What is the sign language word in this video?",
            "a": gloss
        }

        # Append to the instruction data list
        instruction_data.append({
            "video": video_path,
            "QA": [qa_pair]
        })

# Assuming you want to save this to a file
with open('/work/NExT-GPT/data/IT_data/T+X-T_data/videochat/videochat_instruct.json', 'w') as outfile:
    json.dump(instruction_data, outfile, indent=4)

print("Instruction data JSON created successfully.")
