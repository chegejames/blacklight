# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


def bulk_add(file_paths, file_names, solr)
  file_paths.each_with_index{ |path,index|
    f = open(path)
    raw = f.read
    solr.add [{id: index, name: file_names[index], text: raw}]
    f.close()
  }
  solr.commit
end
