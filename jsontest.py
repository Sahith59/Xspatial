
import json
import os

def diagnose_json_issue():
    """Diagnose the exact JSON loading issue"""

    json_file = "kernelSmooth.json"

    print("🔍 ADVANCED JSON DIAGNOSTICS")
    print("=" * 50)

    # Check file size
    file_size = os.path.getsize(json_file)
    print(f"📏 File size: {file_size} bytes")

    try:
        # Read file in different ways to find the issue
        with open(json_file, 'rb') as f:
            raw_bytes = f.read()

        print(f"🔤 Total bytes read: {len(raw_bytes)}")

        # Check for BOM or hidden characters
        if raw_bytes.startswith(b'\xef\xbb\xbf'):
            print("⚠️  UTF-8 BOM detected at start")
        elif raw_bytes.startswith(b'\xff\xfe'):
            print("⚠️  UTF-16 LE BOM detected")
        elif raw_bytes.startswith(b'\xfe\xff'):
            print("⚠️  UTF-16 BE BOM detected")

        # Try different encodings
        encodings_to_try = ['utf-8', 'utf-8-sig', 'latin1', 'cp1252']

        for encoding in encodings_to_try:
            try:
                with open(json_file, 'r', encoding=encoding) as f:
                    content = f.read()

                print(f"✅ Successfully read with {encoding} encoding")
                print(f"📄 First 100 chars: {repr(content[:100])}")

                # Try to parse JSON
                try:
                    data = json.loads(content)
                    print(f"🎉 SUCCESS! JSON parsed with {encoding} encoding")
                    print(f"📊 Data structure: {type(data)}")
                    if isinstance(data, dict):
                        print(f"📊 Keys: {len(data)} environments")
                        sample_keys = list(data.keys())[:3]
                        print(f"📊 Sample keys: {sample_keys}")

                    # Save the working version
                    with open("kernelSmooth_working.json", 'w', encoding='utf-8') as f:
                        json.dump(data, f, indent=2, ensure_ascii=False)

                    print("✅ Saved working version as 'kernelSmooth_working.json'")
                    return True

                except json.JSONDecodeError as e:
                    print(f"❌ JSON parsing failed with {encoding}: {e}")
                    print(f"   Error at line {e.lineno}, column {e.colno}")

                    # Show context around error
                    lines = content.split('\n')
                    if e.lineno <= len(lines):
                        error_line = lines[e.lineno - 1]
                        print(f"   Problem line: {repr(error_line)}")
                        if e.colno < len(error_line):
                            print(f"   Problem char: {repr(error_line[e.colno-1:e.colno])}")

            except UnicodeDecodeError as e:
                print(f"❌ Cannot read with {encoding}: {e}")

        return False

    except Exception as e:
        print(f"❌ Unexpected error: {e}")
        return False

def create_minimal_test():
    """Create a minimal test JSON to verify JSON loading works"""

    print("\n🧪 CREATING MINIMAL TEST")
    print("=" * 30)

    test_data = {
        "0": {
            "0": {"x2": 0, "y": 0.0, "x1": 0},
            "1": {"x2": 1, "y": 0.067, "x1": 0}
        }
    }

    with open("test_minimal.json", 'w', encoding='utf-8') as f:
        json.dump(test_data, f, indent=2)

    # Test loading
    try:
        with open("test_minimal.json", 'r', encoding='utf-8') as f:
            loaded = json.load(f)
        print("✅ Minimal test JSON works perfectly!")
        return True
    except Exception as e:
        print(f"❌ Even minimal test failed: {e}")
        return False

if __name__ == "__main__":
    print("🚀 COMPREHENSIVE JSON DIAGNOSTICS")
    print("=" * 60)

    # Run diagnostics
    if diagnose_json_issue():
        print("\n" + "=" * 60)
        print("✅ PROBLEM SOLVED! Use 'kernelSmooth_working.json'")
        print("   You can rename it back to 'kernelSmooth.json' when ready")
        print("=" * 60)
    else:
        print("\n🔧 Trying minimal test...")
        if create_minimal_test():
            print("\n" + "=" * 60)
            print("❌ MAIN FILE HAS ISSUES - but JSON loading works in general")
            print("   The kernelSmooth.json file might be corrupted")
            print("   Try regenerating it from the original source")
            print("=" * 60)
        else:
            print("\n" + "=" * 60)
            print("❌ SYSTEM ISSUE - JSON loading is broken")
            print("   Check Python installation and file permissions")
            print("=" * 60)