class Skill:
    def __init__(self, name, power, skill_type, effect=None):
        self.name = name
        self.power = power
        self.skill_type = skill_type  # e.g., "fire", "physical"
        self.effect = effect  # Optional status effect


class Character:
    def __init__(self, name, hp, speed, skills):
        self.name = name
        self.max_hp = hp
        self.hp = hp
        self.speed = speed
        self.skills = skills
        self.alive = True

    def take_damage(self, dmg):
        self.hp -= dmg
        if self.hp <= 0:
            self.hp = 0
            self.alive = False
        print(f"{self.name} takes {dmg} damage! ({self.hp} HP left)")

    def choose_action(self, enemies):
        # For now, always use first skill on first alive enemy
        target = next((e for e in enemies if e.alive), None)
        if target:
            return self.skills[0], target
        return None, None
