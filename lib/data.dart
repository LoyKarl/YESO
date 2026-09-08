class Event {
  final String title, description, date, location, category, image;
  final bool isUpcoming;
  Event({required this.title, required this.description, required this.date, required this.location, required this.category, this.image = '', this.isUpcoming = true});
}

class Project {
  final String title, description, status, image;
  final double progress;
  final int volunteers, trees, wasteKg;
  final List<String> updates;
  Project({required this.title, required this.description, required this.status, this.image = '', this.progress = 0, this.volunteers = 0, this.trees = 0, this.wasteKg = 0, this.updates = const []});
}

class TeamMember {
  final String name, role, image;
  TeamMember({required this.name, required this.role, this.image = ''});
}

class Article {
  final String title, category, summary, date;
  Article({required this.title, required this.category, required this.summary, this.date = ''});
}

class GalleryItem {
  final String title, category, image;
  GalleryItem({required this.title, required this.category, this.image = ''});
}

class Data {
  static const int treesPlanted = 110;
  static const int projectsCompleted = 48;
  static const int studentVolunteers = 1500;
  static const int outreachActivities = 156;
  static const int wasteCollectedKg = 60;

  static List<Event> events = [
    Event(title: 'Tree Planting', description: 'Tree planting activity conducted at the school grounds.', date: 'Aug 29, 2026', location: 'School Campus', category: 'Tree Planting', isUpcoming: false),
  ];

  static List<Project> projects = [
    Project(title: 'School Garden Initiative', description: 'Creating a sustainable vegetable and herb garden on campus to promote local food production and biodiversity.', status: 'In Progress', progress: 0.65, volunteers: 85, trees: 0, wasteKg: 0, updates: ['Raised beds constructed (Apr 2026)', 'First seedlings planted (May 2026)', 'Compost system installed (Jun 2026)']),
    Project(title: 'Plastic-Free Campus', description: 'Eliminating single-use plastics across all school facilities through bans, alternatives, and awareness campaigns.', status: 'Completed', progress: 1.0, volunteers: 200, trees: 0, wasteKg: 1500, updates: ['Bottle refill stations installed (Jan 2026)', 'Cafeteria switched to biodegradable packaging (Mar 2026)', '1,500 kg of plastic waste diverted (Jun 2026)']),
    Project(title: 'Rainwater Harvesting System', description: 'Installing rainwater collection systems to irrigate school gardens and reduce water consumption.', status: 'In Progress', progress: 0.4, volunteers: 35, trees: 50, wasteKg: 0, updates: ['System design completed (May 2026)', 'Gutters installed (Jun 2026)']),
    Project(title: 'School-Wide Recycling Program', description: 'Comprehensive recycling program with segregated bins, collection schedule, and partnerships with local recyclers.', status: 'In Progress', progress: 0.8, volunteers: 150, trees: 0, wasteKg: 3000, updates: ['Bin stations deployed in all buildings (Feb 2026)', 'Monthly collection started (Mar 2026)', '3,000 kg recycled to date (Jun 2026)']),
    Project(title: 'Energy Conservation Campaign', description: 'Reducing the school\'s carbon footprint through energy-efficient lighting, solar panels, and conservation awareness.', status: 'Completed', progress: 1.0, volunteers: 60, trees: 0, wasteKg: 0, updates: ['LED retrofitting completed (Dec 2025)', 'Solar panels installed on roof (Feb 2026)', '30% reduction in energy consumption (Apr 2026)']),
  ];

  static List<TeamMember> officers = [
    TeamMember(name: 'Maria Santos', role: 'President'),
    TeamMember(name: 'Jose Cruz', role: 'Vice President'),
    TeamMember(name: 'Ana Reyes', role: 'Secretary'),
    TeamMember(name: 'Carlos Lim', role: 'Treasurer'),
    TeamMember(name: 'Diana Chen', role: 'Auditor'),
    TeamMember(name: 'Mark Garcia', role: 'P.R.O.'),
  ];

  static List<TeamMember> advisers = [
    TeamMember(name: 'Dr. Emilia Ramos', role: 'Adviser'),
    TeamMember(name: 'Mr. Ricardo Torres', role: 'Co-Adviser'),
  ];

  static List<Article> articles = [
    Article(title: 'Understanding Climate Change: A Student\'s Guide', category: 'Climate Change', summary: 'Learn the science behind global warming and how young people can take meaningful action.', date: 'Jan 2026'),
    Article(title: 'The Amazing Biodiversity of the Philippines', category: 'Biodiversity', summary: 'Discover why the Philippines is a megadiverse country and what species are at risk.', date: 'Feb 2026'),
    Article(title: 'Waste Management 101: Reduce, Reuse, Recycle', category: 'Waste Management', summary: 'Practical tips for managing waste at home and in school.', date: 'Mar 2026'),
    Article(title: 'Renewable Energy: Powering a Sustainable Future', category: 'Renewable Energy', summary: 'Explore solar, wind, and hydro power and how they can replace fossil fuels.', date: 'Apr 2026'),
    Article(title: 'Conservation Strategies for Local Ecosystems', category: 'Conservation', summary: 'How student-led efforts can protect forests, rivers, and coastal areas.', date: 'May 2026'),
    Article(title: 'Filipino Scientists Making a Difference', category: 'Scientific Innovations', summary: 'Meet the Filipino innovators whose discoveries are shaping environmental science.', date: 'Jun 2026'),
  ];

  static List<GalleryItem> gallery = [
    GalleryItem(title: 'Tree Planting Aug 29 - Photo 1', category: 'Tree Planting', image: 'assets/tree planting aug29/f2da42ac-8b89-45ea-be5a-3fdb77de222c.jpg'),
    GalleryItem(title: 'Tree Planting Aug 29 - Photo 2', category: 'Tree Planting', image: 'assets/tree planting aug29/1e7893e3-8830-40a9-b443-df77dd61fd05.jpg'),
    GalleryItem(title: 'Tree Planting Aug 29 - Photo 3', category: 'Tree Planting', image: 'assets/tree planting aug29/150783c1-0738-46cb-8515-b071d0ff688e (1).jpg'),
    GalleryItem(title: 'Tree Planting Aug 29 - Photo 4', category: 'Tree Planting', image: 'assets/tree planting aug29/0511e8a0-a362-4e3e-bbc4-d0f8bd048c5a.jpg'),
  ];

  static const List<String> funFacts = [
    'A single tree can absorb up to 48 pounds of CO₂ per year!',
    'The Philippines is home to over 200 species of mammals and 600 species of birds.',
    'Recycling one aluminum can saves enough energy to power a TV for 3 hours.',
    'Plastic takes up to 450 years to decompose in the ocean.',
    'Solar energy is the most abundant energy source on Earth.',
    'Over 80% of marine pollution comes from land-based activities.',
    'Bamboo grows faster than any other plant on the planet.',
    'Coral reefs support 25% of all marine species.',
  ];
}
