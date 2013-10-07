require 'json'

module WhatsNext

  module Serializer

    def self.load(string)
      hash = JSON.parse(string)
      load_workspace(hash)
    end

    def self.load_from_redis(key)
      string = Env.redis.get(key)
      load(string)
    end

    def self.dump(workspace)
      dump_workspace(workspace).to_json
    end

    def self.dump_on_redis(workspace, key)
      string = dump(workspace)
      Env.redis.set(key, string)
    end

    private

    def self.dump_workspace(workspace)
      Hash.new.tap do |hash|
        hash['current_project'] = workspace.current_project.name if workspace.current_project
        hash['projects']        = {}

        workspace.projects.each do |project_name, project|
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
        hash['text']   = task.text

        hash['status'] = '!' if task.foreground?
        hash['status'] = '-' if task.background?
        hash['status'] = 'X' if task.finished?

        hash['notes']  = task.notes
      end
    end

    def self.load_project(project_name, project_hash)
      Project.new(project_name).tap do |project|
        project_hash['tasks'].each do |task_hash|
          project.tasks << load_task(task_hash)
        end
      end
    end

    def self.load_workspace(hash)
      Workspace.new.tap do |workspace|    
        hash['projects'].each do |project_name, project_hash|
          project = load_project(project_name, project_hash)
          workspace.projects[project_name] = project
        end

        workspace.current_project = hash['current_project']
      end
    end

    STATUSES = { '!' => :foreground, '-' => :background, 'X' => :finished }

    def self.load_task(task_hash)
      text   = task_hash['text']
      status = STATUSES[ task_hash['status'] ]
      notes  = Array(task_hash['notes'])

      Task.new(text, status).tap do |task|
        task.notes.concat notes
      end
    end

  end

end
