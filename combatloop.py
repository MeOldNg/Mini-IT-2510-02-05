import random

def battle(playparty, enemy):
    all_combatants = playparty + enemy
    turn_order = sorted(all_combatants, key=lambda x: x.speed, reverse=True)

    while any(p.alive for p in playparty) and any(e.alive for e in enemy):
        print("\n--- New Round ---")
        for char in turn_order:
            if not char.alive:
                continue

            enemies = enemy if char in playparty else playparty
            skill, target = char.choose_action(enemies)

            if skill and target:
                print(f"{char.name} uses {skill.name} on {target.name}!")
                damage = random.randint(skill.power - 3, skill.power + 3)
                target.take_damage(damage)

        # Check victory
        if not any(e.alive for e in enemy):
            print("\nVictory! All enemies defeated.")
            return
        elif not any(p.alive for p in playparty):
            print("\nDefeat... Your party has fallen.")
            return
