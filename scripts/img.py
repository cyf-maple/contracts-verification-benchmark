import matplotlib.pyplot as plt
import pandas as pd

# Load the file to inspect its contents
file_path = '../contracts/bank/solcmc/time.csv'
df = pd.read_csv(file_path)

# Show the first few rows of the dataframe to understand its structure
df.head()


# Clean up the first column by removing the common parts of the path
df.columns = ['File', 'Time', 'Memory']
df['File'] = df['File'].apply(lambda x: x.split('/')[-1])  # Keep only the file name

# Convert the memory column to numeric by removing "MB" and converting to float
df['Memory'] = df['Memory'].str.replace(' MB', '').astype(float)

# Plot the data
fig, ax1 = plt.subplots()

# Bar chart for time
ax1.bar(df['File'], df['Time'], color='b', label='Time (s)', alpha=0.6)
ax1.set_xlabel('File')
ax1.set_ylabel('Time (s)', color='b')

# Rotate x-axis labels for better readability
plt.xticks(rotation=90)

# Create another y-axis for memory
ax2 = ax1.twinx()
ax2.plot(df['File'], df['Memory'], color='r', marker='o', label='Memory (MB)')
ax2.set_ylabel('Memory (MB)', color='r')

plt.title('Time and Memory Usage per Contract File')
plt.tight_layout()

# Show the plot
plt.show()
