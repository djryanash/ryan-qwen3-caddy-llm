import runpod

def streaming_handler(job):
    for count in range(3):
        result = f"This is the {count} generated output."
        yield result

runpod.serverless.start({
    "handler": streaming_handler,
    "return_aggregate_stream": True  # Optional, makes results available via /run
})