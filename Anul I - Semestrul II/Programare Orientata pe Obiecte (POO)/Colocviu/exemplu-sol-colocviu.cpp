#include <iostream>
#include <string>
#include <memory>
#include <algorithm>

// Clasa Abstracta + Metode virtuale pure
class Stream {
public:
    virtual void read(std::istream &is) = 0;
    virtual void print(std::ostream &os) const = 0; // metode const
};

// Generator Id
// folosirea membrilor statici
class IdGenerator {
    static int nr;

public:
    static int generateId();
    IdGenerator() = delete;
};
int IdGenerator::nr = 100;

int IdGenerator::generateId() {
    return nr++;
}


class Pet : public Stream {
private:
    const int id; // folosire const
protected:
    std::string name;

public:
    Pet();
    Pet(std::string name);

    virtual ~Pet() = default; // dctr clasa baza mereu trebuie declarat virtual

    void print(std::ostream &os) const override;

    int getId() const;
    std::string getName() const;

    friend std::istream &operator>>(std::istream &is, Pet &pet);
};


// folosire lista initializare
Pet::Pet() : id(IdGenerator::generateId()) {}


// ordinea elementelor in lista de initializare trebuie sa fie aceasi ca in definitia clasei
Pet::Pet(std::string name) : id(IdGenerator::generateId()), name(name) {

}

int Pet::getId() const {
    return id;
}

std::string Pet::getName() const {
    return name;
}

// metoda virtuala simpla
void Pet::print(std::ostream &os) const {
    os << id;
}

std::ostream &operator<<(std::ostream &os, const Pet &pet) {
    pet.print(os); // apelare indirecta pt comportament corect la up-casting
    return os;
}

std::istream &operator>>(std::istream &is, Pet &pet) {
    pet.read(is);
    return is;
}

// Mostenire
class Dog : public Pet {
    std::string favToy;
public:
    // daca omitem clasa baza in lista de initializare se apeleaza implicit constructorul ei default
    Dog() = default;
    Dog(std::string name, std::string favToy);

    void print(std::ostream &os) const override;
    void read(std::istream &is) override;

    std::string getFavToy() const;
};

// Pet(name) pentru ca trebuie initializata clasa baza
// nu puteti scrie name(name)
Dog::Dog(std::string name, std::string favToy) : Pet(name), favToy(favToy) {

}

std::string Dog::getFavToy() const {
    return favToy;
}

void Dog::print(std::ostream &os) const {
    os << "Dog ";
    Pet::print(os);
    os << " " << name << " " << favToy;
}

void Dog::read(std::istream &is) {
    is >> name >> favToy;
}

class Cat : public Pet {
    std::string favToy;
public:
    Cat() = default;
    Cat(std::string name);
    void print(std::ostream &os) const override;

    void read(std::istream &is) override;
};

Cat::Cat(std::string name) : Pet(name) {}

void Cat::read(std::istream &is) {
    is >> name;
}

void Cat::print(std::ostream &os) const {
    os << "Cat ";
    Pet::print(os);
    os << " " << name;
}

// Exceptii
class InvalidInput : public std::exception {
public:
    const char* what() const noexcept override;
};

const char *InvalidInput::what() const noexcept {
    return "Invalid input";
}

class Factory {
public:
    static std::shared_ptr<Pet> makePet(std::string pet);
};

std::shared_ptr <Pet> Factory::makePet(std::string pet) {
    if (pet == "dog")
        return std::make_shared<Dog>();

    if (pet == "cat")
        return std::make_shared<Cat>();

    throw InvalidInput();
}

// Singleton
class Menu {
    static Menu* instance;

    std::vector<std::shared_ptr<Pet>> pets;

    Menu() = default;

public:
    static Menu* getInstance();

    Menu(const Menu&) = delete;
    Menu& operator=(const Menu&) = delete;

    void run();
};

Menu* Menu::instance = nullptr;

Menu* Menu::getInstance() {
    if (!instance)
        instance = new Menu();
    return instance;
}

void Menu::run() {
    do {
        std::cout << "1. Create pet\n";
        std::cout << "2. Search pet\n";
        std::cout << "3. Show all pets\n";
        std::cout << "4. Exit\n\n";

        int cid;
        std::string kind;
        std::string name;

        std::cout << "> ";
        std::cin >> cid;

        switch (cid) {
            case 1:
                std::cout << "What kind? ";
                std::cin >> kind;

                try {
                    auto pet = Factory::makePet(kind);
                    std::cin >> *pet;
                    pets.push_back(pet);
                } catch (const InvalidInput& e) {
                    std::cout << e.what() << '\n';
                }
                break;
            case 2: {
                    std::cout << "Name: ";
                    std::cin >> name;

                    // arcolade pt a putea folosi auto
                    auto it = std::find_if(pets.begin(), pets.end(), [name](auto pet) { return pet->getName() == name; });

                    if (it == pets.end())
                        std::cout << "Not found\n";
                    else
                        std::cout << **it << '\n';
                    }
                break;
            case 3:
                for (auto pet : pets)
                    std::cout << *pet << "\n";

                break;
            case 4:
                return;
        }

        std::cout << "Done\n\n";
    } while (true);
}

int main() {
    Menu::getInstance()->run();
}