require 'json'

module WhatsNext

  module Serializer

    def self.load(string)
      hash = JSON.parse(string)

      ProjectList.new.tap do |project_list|    
        hash['projects'].each do |project_name, project_hash|
          project = load_project(project_name, project_hash)
          project_list.projects[project_name] = project
        end

        project_list.current_project = hash['current_project']
      end
    end

    def self.dump(project_list)
      dump_project_list(project_list).to_json
    end

    private

    def self.dump_project_list(project_list)
      Hash.new.tap do |hash|
        hash['current_project'] = project_list.current_project.name if project_list.current_project
        hash['projects']        = {}

        project_list.projects.each do |project_name, project|
          hash['projects'][project_name] = dump_project(project)
        end
      end
    end

    def self.dump_project(project)
      Hash.new.tap do |hash|
        hash['name']  = project.name
        hash['tasks'] = []

        project.tasks.each do |task|
          hash['tasks'] << dump_task(task)
        end
      end
    end

    def self.dump_task(task)
      Hash.new.tap do |hash|
        hash['text'] = task.text

        hash['status'] = '!' if task.foreground?
        hash['status'] = '-' if task.background?
        hash['status'] = 'X' if task.finished?
      end
    end

    def self.load_project(project_name, project_hash)
      Project.new(project_name).tap do |project|
        project_hash['tasks'].each do |task_hash|
          project.tasks << load_task(task_hash)
        end
      end
    end

    STATUSES = { '!' => :foreground, '-' => :background, 'X' => :finished }

    def self.load_task(task_hash)
      text   = task_hash['text']
      status = STATUSES[ task_hash['status'] ]

      Task.new(text, status)
    end

  end

end
