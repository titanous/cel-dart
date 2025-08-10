#!/bin/bash

# Convert all textproto test files to JSON using buf

TEST_DIR="../cel-spec/tests/simple/testdata"
OUTPUT_DIR="test/testdata"

mkdir -p "$OUTPUT_DIR"

for file in "$TEST_DIR"/*.textproto; do
  basename=$(basename "$file" .textproto)
  echo "Converting $basename..."
  
  buf convert proto \
    --type=cel.expr.conformance.test.SimpleTestFile \
    --from="$file#format=txtpb" \
    --to="$OUTPUT_DIR/${basename}.json#format=json" \
    2>/dev/null
done

echo "Conversion complete!"