import time
import random

class McuonghuhGarden:
    def __init__(self, owner_name):
        self.owner = owner_name
        self.plants = []
        self.soil_moisture = 50  # Độ ẩm từ 0-100
        self.day = 1

    def add_plant(self, plant_name, species):
        self.plants.append({
            'name': plant_name,
            'species': species,
            'growth': 0,
            'status': 'Hạt giống'
        })
        print(f"[{self.owner}] đã trồng cây {plant_name} ({species})!")

    def simulate_day(self):
        print(f"\n--- Ngày {self.day} tại vườn {self.owner} ---")
        self.soil_moisture -= random.randint(5, 15)
        
        for plant in self.plants:
            if self.soil_moisture > 30:
                plant['growth'] += random.randint(10, 20)
                self.update_status(plant)
            else:
                print(f"Cây {plant['name']} đang héo vì thiếu nước!")
        
        self.day += 1

    def update_status(self, plant):
        if plant['growth'] >= 100:
            plant['status'] = 'Đã trưởng thành'
        elif plant['growth'] >= 50:
            plant['status'] = 'Đang ra hoa'
        else:
            plant['status'] = 'Đang phát triển'

    def show_garden(self):
        print(f"\n--- Trạng thái vườn của {self.owner} ---")
        print(f"Độ ẩm đất: {max(0, self.soil_moisture)}%")
        for p in self.plants:
            print(f"- {p['name']} ({p['species']}): {p['status']} ({p['growth']}%)")

# Chạy mô phỏng
my_garden = McuonghuhGarden("Mcuonghuh")
my_garden.add_plant("Hoa Hồng", "Rosa")
my_garden.add_plant("Cây Cà Chua", "Solanum")

for _ in range(3):
    my_garden.simulate_day()
    my_garden.show_garden()
    time.sleep(1)
