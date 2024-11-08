class Monster {
  String name;
  int health;
  int maxAttack;

  Monster(this.name, this.health, this.maxAttack);

  void showStatus() {
    print('$name - 체력: $health, 공격력: $maxAttack');
  }
}
