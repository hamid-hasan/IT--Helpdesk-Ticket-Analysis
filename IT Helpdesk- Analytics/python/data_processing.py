import pandas as pd
import random
from datetime import datetime, timedelta

# 500 tickets generate karna hai
num_tickets = 500

employees = [f"E{i:03d}" for i in range(1, 51)]

engineers = [
    "IT001",
    "IT002",
    "IT003",
    "IT004",
    "IT005"
]

categories = [
    "Network",
    "Software",
    "Hardware",
    "Access"
]

priorities = [
    "Critical",
    "High",
    "Medium",
    "Low"
]

statuses = [
    "Resolved",
    "Resolved",
    "Resolved",
    "Open",
    "In Progress"
]

notes = {
    "Network": [
        "Wi-Fi connection fixed",
        "VPN configuration fixed",
        "Network adapter restarted",
        "Internet connectivity restored"
    ],

    "Software": [
        "Application reinstalled",
        "Outlook repaired",
        "Software updated",
        "Application issue resolved"
    ],

    "Hardware": [
        "Keyboard replaced",
        "Laptop issue fixed",
        "Monitor cable replaced",
        "Hardware component replaced"
    ],

    "Access": [
        "Password reset",
        "Account unlocked",
        "User permission updated",
        "Access restored"
    ]
}

data = []

start_date = datetime(2026, 1, 1)

for i in range(1, num_tickets + 1):

    category = random.choice(categories)
    priority = random.choice(priorities)
    status = random.choice(statuses)

    created_at = start_date + timedelta(
        days=random.randint(0, 240),
        hours=random.randint(0, 8),
        minutes=random.randint(0, 59)
    )

    assigned_at = created_at + timedelta(
        hours=random.randint(0, 4)
    )

    if status == "Resolved":

        resolved_at = assigned_at + timedelta(
            hours=random.randint(1, 48)
        )

        resolution_note = random.choice(notes[category])

    else:

        resolved_at = ""
        resolution_note = ""

    data.append([
        f"T{i:04d}",
        random.choice(employees),
        category,
        priority,
        status,
        random.choice(engineers),
        created_at,
        assigned_at,
        resolved_at,
        resolution_note
    ])


columns = [
    "ticket_id",
    "employee_id",
    "category",
    "priority",
    "status",
    "engineer_id",
    "created_at",
    "assigned_at",
    "resolved_at",
    "resolution_notes"
]

df = pd.DataFrame(data, columns=columns)

# CSV file save karna
df.to_csv("data/tickets.csv", index=False)

print("500 tickets successfully generated!")
print(df.head())