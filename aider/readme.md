# Aider Setup Files 
Below is my aider setup to use this across my development files

## How to 

To use a specific model every single time in a project you are working on, just add a `~/.aider.conf.yml`:


```

model: litellm_proxy/gemini-2.5-pro
weak-model: litellm_proxy/gemini-2.5-flash

```

Then every time you start `aider` in that directory those models will be used.


## Models: Work

### "Frontier Reasoning for Practical Coding" - more complex tasks: 
aider --model litellm_proxy/claude-opus-4

### "The Reliable and Efficient Coding Partner" - everyday tasks
aider --model litellm_proxy/claude-sonnet-4

### "Speed and Multimodality for Agile Development" - vibe coding
aider --model litellm_proxy/gemini-2.5-flash
