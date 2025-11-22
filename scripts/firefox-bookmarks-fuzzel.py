import os
import sqlite3

# Set your profile path and desktop entry directory
profile_path = "/home/rejin/.mozilla/firefox/8okwcnyi.default"
db_path = os.path.join(profile_path, "places.sqlite")
desktop_dir = os.path.expanduser("~/.local/share/applications")

# Remove all previous bookmark desktop files (optional for cleanup)
for fname in os.listdir(desktop_dir):
    if fname.startswith("firefox_bookmark_") and fname.endswith(".desktop"):
        try:
            os.remove(os.path.join(desktop_dir, fname))
        except Exception:
            pass

conn = sqlite3.connect(db_path)
c = conn.cursor()

query = """
SELECT b.title, p.url
FROM moz_bookmarks b
JOIN moz_places p ON b.fk = p.id
WHERE b.type = 1 AND p.url LIKE 'http%';
"""

c.execute(query)
bookmarks = c.fetchall()

for title, url in bookmarks:
    # Fallback if title is empty  
    display_title = title if title else url
    # Sanitize title for filename
    safe_title = "".join(c for c in display_title if c.isalnum() or c in " _-").strip()
    if not safe_title:
        safe_title = "untitled"
    desktop_file = os.path.join(desktop_dir, f"firefox_bookmark_{safe_title}.desktop")
    with open(desktop_file, "w") as f:
        f.write(f"""[Desktop Entry]
Name={display_title}
Exec=firefox "{url}"
Type=Application
Categories=Bookmarks;
""")

conn.close()

