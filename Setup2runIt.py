# Define some skills
from os import kill

# Define the Character class
class Character:
	def __init__(self, name, health, attack, skills):
		self.name = name
		self.health = health
		self.attack = attack
		self.skills = skills


slash = kill("Slash", 10, "physical")
fireball = kill("Fireball", 12, "magic")

# Create characters
hero = Character("Hero", 50, 7, [slash])
monkey = Character("monkey", 40, 5, [fireball])
apes = Character("apes", 30, 6, [slash])
robot = Character("robot", 45, 4, [slash])


