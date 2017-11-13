**Kubernetes 101: An Introduction**

\<dug\>

Some feedback from Lin Sun:

-   Say/show we're using kube 1.7 not 1.5
-   When done, let's put the source code/files into a github repo for
    each download/access.
-   Add a 'duration" to each section so people know how much time to
    allocate for each one. This will also help us estimate the total
    length of time to schedule for the workshop.

Additional things we need to make sure we cover:

-   What is IBM doing in and with Kube? I think we cover some of this
    already - is it sufficient?
-   Why should people use Kube over other technologies - like Docker and
    Mesos?

\</dug\>

[]{#anchor}Introduction

IBM Cloud provides the capability to run Applications in Containers on
Kubernetes. The IBM Cloud Container Service runs Kubernetes clusters
which deliver:

-   Powerful tools
-   Excellent user experience
-   Built-in security and isolation to enable rapid delivery of secure
    applications
-   Cloud Services including cognitive capabilities from Watson
-   Capability to manage dedicated cluster resources for both stateless
    (microservice) applications and stateful workloads

In this workshop you will learn about the IBM Cloud container service
while walking through the process of deploying a typical 3-tier
application (web front-end, web application and backend datastore) to a
Kubernetes cluster.

In order to get started lets first set up an IBM Cloud account and kick
off the process of creating the Kubernetes cluster since that might take
minutes. While that is happening we will explore the basics of container
technology and Kubernetes.

Note: This workshop leverages the IBM Cloud container service but the
core workshop procedure should work on any Kubernetes environment. The
exception to this is the initial setup of the IBM Cloud account and the
provisioning of a new Kubernetes cluster on the IBM Cloud.

Creating a Kubernetes Cluster[]{#anchor-1} on the IBM Cloud

[]{#anchor-2}The steps for initializing a Kubernetes cluster on the IBM
Cloud are as follows:

-   If you do not have one yet, create an IBM Cloud account:
    https://console.bluemix.net/registration/
-   Set up the IBM Cloud CLI:
    https://github.com/IBM/container-journey-template\#step-1-setting-up-the-bluemix-cli
-   Install the IBM Cloud Container Service Plugin for using the
    Kubernetes API:
    https://github.com/IBM/container-journey-template\#step-1-setting-up-the-bluemix-cli
-   Create a Kubernetes cluster with one worker node:
    [*https://github.com/IBM/container-journey-template\#step-2-setting-up-your-cluster-environment*](https://github.com/IBM/container-journey-template#step-2-setting-up-your-cluster-environment)

While the Kubernetes cluster is being provisioned (following step 1 in
[*https://github.com/IBM/container-journey-template\#step-2-setting-up-your-cluster-environment*](https://github.com/IBM/container-journey-template#step-2-setting-up-your-cluster-environment)

), why not get some background knowledge of Containers and Kubernetes by
reading the two sections that follow!

[]{#anchor-3}Introduction To Containers

Containers allows you to run securely isolated applications with quotas
on system resources. Containers started out as an individual feature
delivered with the Linux kernel. Docker launched with the promise of
making containers easy to use and developers quickly latched onto that
idea.. Containers have also sparked an interest in microservice
architecture, a design pattern for developing applications in which
complex applications are broken down into smaller, composable pieces
which work together. You can run containers on both Linux and Windows,
even though they share little of the same underlying technology.

[]{#anchor-4}Virtual Machines

Prior to containers, most infrastructure ran not on bare metal, but
within hypervisors managing multiple virtualized Operating Systems
(OSes). This arrangement allowed isolation of applications from one
another on a higher level than that provided by the OS. These
virtualized operating systems see what looks like their own exclusive
hardware. However, this also means that each of these virtual operating
systems are replicating an entire OS , taking up disk space.

[]{#anchor-5}Containers

Containers provide isolation similar to VMs, but provided by the
Operating System and at the process level. Each container is a process
or group of processes run in isolation. Typical containers explicitly
run only a single process, as they do not need of the standard system
services. What they usually need to do can be provided by system calls
to the base OS kernel.

The isolation on linux is provided by a feature called 'namespaces'.
Each different kind of isolation is provided by a different namespace.

This is a list of some of the namespaces that are commonly used and
visible to the user:

-   PID - process IDs
-   USER - user and group IDs
-   UTS - hostname and domain name
-   NS - mount points
-   NET - Network devices, stacks, ports
-   cgroups - controls limits and monitoring of resources

[]{#anchor-6}VM vs Container

Traditional applications are run on native machines. A single
application does not typically use full resources of a single machine.
We try to run multiple applications on a single machine to avoid wasting
resources. We could run multiple copies of the same application, but to
provide isolation we used VMs to run multiple application instances on
the same hardware. These VMs have full operating system stacks which
make them relatively large and inefficient due to duplication both at
runtime and on disk.

Containers allow you to share the host OS. This reduces duplication
while still providing the isolation.

Containers allow you to drop unneeded files such as system libraries and
binaries to save space, and reduce your attack surface. If sshd or libc
is not installed, it cannot be exploited.

![](Pictures/1000020100000866000004DCE81DC0BCEB865787.png){width="6.5in"
height="3.7638in"}

[]{#anchor-7}Why Containers?

-   Fast startup time - only takes milliseconds to:

    -   Create a new directory

    -   Lay-down the container\'s filesystem

    -   Setup the networks, mounts, ...

    -   Start the process

-   Better resource utilization

    -   Can fit far more containers than VMs into a host

\

Containers allow you to modernise your existing monolithic applications.
But the essential glue to build a application lies with a strong
Container Orchestrator that you chose to deploy your multi-container
application. Kubernetes is one of the most popular such tools.

[]{#anchor-8}Kubernetes : An Overview

Let us talk about Kubernetes before we build a application on it. We
need to understand the following facts about Kubernetes.

-   What is Kubernetes?
-   How was Kubernetes created?
-   Where is the Kubernetes at?
-   Kubernetes Architecture
-   Resource Model
-   Kubernetes at IBM
-   Let\'s Get Started

[]{#anchor-9}What is Kubernetes?

Now that we know what containers are, let us define what Kubernetes is.
Kubernetes is a container orchestrator to provision, manage, and scale
applications. In other words Kubernetes allows you to manage the
lifecycle of containerised applications within a cluster of Nodes (which
are a collection of worker machines, for example, VMs, physical machines
etc.).

Your applications need many other resources to run such as Volumes,
Networks, Secrets that will help you to do things such as connect to
databases, talk to firewalled backends, and secure keys. Kubernetes
helps you add these resources into your application.

Infrastructure resources needed by applications are managed
declaratively.

The key paradigm of kubernetes is it's Declarative model. The user
provides the \"desired state\" and Kubernetes will make it happen. If
you need 5 instances, you do not start 5 separate instances on your own
but rather tell Kubernetes that you need 5 instances and Kubernetes will
reconcile the state automatically. Simply at this point you need to know
that you declare the state you want and Kubernetes makes that happen. If
something goes wrong with one of your instances and it crashes,
Kubernetes still knows the desired state and restores the crashed
instances on an available node.

Kubernetes goes by many names. Sometimes it is shortened to k8s (losing
the internal 8 letters), or kube. The word is rooted in ancient greek
and means \"Helmsman\". A helmsman is the person who steers a ship. We
hope you can seen the analogy between directing a ship and the decisions
made to orchestrate containers on a cluster.

[]{#anchor-10}How was Kubernetes created?

Google wanted to open source their knowledge of creating and running the
internal tools Borg & Omega. It adopted Open Governance by starting the
Cloud Native Computing Foundation (CNCF) and therefore making it less
influenced by Google. Many companies such as RedHat, Microsoft, IBM and
Amazon quickly joined the foundation.

[]{#anchor-11}Where is Kubernetes at?

Kubernetes is built on the experience of Google when running cloud scale
applications on their internal product called Borg. As Google open
sourced the project, it allows you to download the code, play with it
and if you want to make changes, you can do so and contribute back.
Kubernetes contributor community grew incredibly fast as many companies
realized the value of the project.

Due to Open Governance of Kubernetes, the community of contributors
decide on all aspects of the project including design, development and
release cycles. Google or any other company do not dictate the direction
of the project. The community itself is responsible for the fate of the
project.

Main entry point for the kubernetes project is at
[*http://kubernetes.io*](http://kubernetes.io) and the source code can
be found at
[*https://github.com/kubernetes*](https://github.com/kubernete).

[]{#anchor-12}Kubernetes Architecture

At its core, Kubernetes is a data store (etcd). The declarative model is
stored in the data store as objects, that means when you say I want 5
instances of a container then that request is stored into the data
store. This information change is watched and delegated to Controllers
to take action. Controllers then react to the model and attempt to take
action to achieve the desired state. The power of Kubernetes is in its
simplistic model.

As shown, API server is a simple HTTP server handling
create/read/update/delete(CRUD) operations on the data store. Then the
controller picks up the change you wanted and makes that happen.
Controllers are responsible for instantiating the actual resource
represented by any Kubernetes resource. These actual resources are what
your application needs to allow it to run successfully.

![](Pictures/10000000000004C8000002E9069E7253F6A38C20.png){width="6.3752in"
height="3.861in"}

[]{#anchor-13}Kubernetes Resource Model

Kubernetes Infrastructure defines a resource for every purpose. Each
resource is monitored and processed by a controller. When you define
your application, it contains a collection of these resources. This
collection will then be read by Controllers to build your applications
actual backing instances. Some of resources that you may work with are
listed below for your reference, for a full list you should go to
https://kubernetes.io/docs/concepts/. In this class we will only use a
few of them, like Pod, Deployment, etc.

-   **Config Maps** holds configuration data for pods to consume.
-   **Daemon Sets** ensure that each node in the cluster runs this Pod
-   **Deployments** defines a desired state of a deployment object
-   **Events** provides lifecycle events on Pods and other deployment
    objects
-   **Endpoints** allows a inbound connections to reach the cluster
    services
-   **Ingress** is a collection of rules that allow inbound connections
    to reach the cluster services
-   **Jobs** creates one or more pods and as they complete successfully
    the job is marked as completed
-   **Node** is a worker machine in Kubernetes
-   **Namespaces** are multiple virtual clusters backed by the same
    physical cluster
-   **Pods** are the smallest deployable units of computing that can be
    created and managed in Kubernetes
-   **Persistent Volumes** provides an API for users and administrators
    that abstracts details of how storage is provided from how it is
    consumed
-   **Replica Sets** ensures that a specified number of pod replicas are
    running at any given time
-   **Secrets** are intended to hold sensitive information, such as
    passwords, OAuth tokens, and ssh keys
-   **Service Accounts** provides an identity for processes that run in
    a Pod
-   **Services** is an abstraction which defines a logical set of Pods
    and a policy by which to access them - sometimes called a
    micro-service.
-   **StatefulSet** is the workload API object used to manage stateful
    applications.
-   and more\...

Kubernetes does not have the concept of an application. It has simple
building blocks that you are required to compose. Kubernetes is a cloud
native platform where the internal resource model is the same as the end
user resource model.

[]{#anchor-14}Key Resources

A Pod is the smallest object model that you can create and run. You can
add labels to a pod to identify a subset to run operations on. When you
are ready to scale your application you can use the label to tell
Kubernetes which Pod you need to scale. A Pod typically represent a
process in your cluster. Pods contain at least one container that runs
the job and additionally may have other containers in it called sidecars
for monitoring, logging, etc. Essentially a Pod is a group of
containers.

When we talk about a application, we usually refer to group of Pods.
Although an entire application can be run in a single Pod, we usually
build multiple Pods that talk to each other to make a useful
application. We will see why separating the application logic and
backend database into separate Pods will scale better when we build an
application shortly.

Services define how to expose your app as a DNS entry to have a stable
reference. We use query based selector to choose which pods are
supplying that service.

The user directly manipulates resources via yaml:

**\$ kubectl (create\|get\|apply\|delete) -f myResource.yaml**

Kubernetes provides us with a client interface through 'kubectl'.
Kubectl commands allow you to manage your applications, manage cluster
and cluster resources, by modifying the model in the data store.

Kubernetes Application Deployment Workflow

![](Pictures/10000000000004C8000002720E1417FBC2463E87.png){width="6.3752in"
height="3.25in"}

1.  User via \"kubectl\" deploys a new application. Kubectl sends the
    request to the API Server.
2.  API server receives the request and stores it in the data store
    (etcd). Once the request is written to data store, the API server is
    done with the request.
3.  Watchers detects the resource changes and send a notification to
    controller to act upon it
4.  Controller detects the new app and creates new pods to match the
    desired number of instances. Any changes to the stored model will be
    picked up to create or delete Pods.
5.  Scheduler assigns new pods to a Node based on a criteria. Scheduler
    makes decisions to run Pods on specific Nodes in the cluster.
    Scheduler modifies the model with the node information.
6.  Kubelet on a node detects a pod with an assignment to itself, and
    deploys the requested containers via the container runtime (e.g.
    Docker). Each Node watches the storage to see what pods it is
    assigned to run. It takes necessary actions on resource assigned to
    it like create/delete Pods.
7.  Kubeproxy manages network traffic for the pods -- including service
    discovery and load-balancing. Kubeproxy is responsible for
    communication between Pods that want to interact.

[]{#anchor-15}Simple Web Application

So far we have talked about Containers and Kubernetes and setup on the
cloud. Time to test drive by building a simple application that will run
in a Kubernetes cluster on the IBM Cloud. As part of this process we
will run and test each of the containers that are deployed as part of
the application. We build and then deploy both web and redis containers
as an application to run as a single application.

We start with a containerized web application and with a standard redis
server container image to build a typical enterprise application as part
of modernizing it. We will then move these containerized components of
the application into the cloud on Kubernetes and scale it.

Section Scenario (we as an attendee of the class)

-   We have an existing containerized application. It is being run in
    production without an orchestrator, or with some other VM focused
    orchestrator.
-   We want to use a container native orchestrator
-   We want to use a cloud provider to avoid knowing details of
    Kubernetes setup (and most kubernetes administration)
-   We want to focus on using kubernetes.
-   Our webapp is a standard three tier app

    -   Web browser is the very simple presentation layer

    -   The webserver is the business logic layer

        -   This is the one that should be 12 factor style

    -   Redis is the data storage layer

-   We want to first get a feel for running the webapp by itself, and
    then hook it up to the services it needs, and expose it to the user.
-   Once we have the webapp up and running, we'll show how to do some
    basic scaling.

![](Pictures/10000201000002ED000001A40C1E2C9F88DD4D98.png){width="6.5in"
height="3.639in"}

Before we begin the exercise, please download the web application code
from
[*https://github.com/brahmaroutu/kube101*](https://github.com/brahmaroutu/kube101)
using the following command:

**\$ git clone https://github.com/brahmaroutu/kube101.git**

[]{#anchor-16}3-Tier Web Application

The application we're going to be using is a simple 3-tier application.
It has a webpage that talks to an application, that's written in python.
This application then then talk to a backend redis server to count the
number of hits to the application. We're mostly ignoring any
complexities in the presentation layer (webpage), and using the
web-browser simply to access the output of the business logic tier.

Let's first take a quick look at the application itself (go to directory
where you cloned the code base), and notice that will both show a very
simple web page (see the "return" line) as well as increment the "hits"
counter (see the "redis.incr" call):

**\$ cat web/app.py**

from flask import Flask

from redis import Redis

import os

import platform

app = Flask(\_\_name\_\_)

redis = Redis(host=os.environ.get(\'REDIS\_HOST\', \'redis\'),
port=6379)

@app.route(\'/\')

def hello():

 redis.incr(\'hits\')

 return \'Hello Container World from %s! I have been seen %s times.\\n\'
% ( platform.node(), redis.get(\'hits\') )

if \_\_name\_\_ == \"\_\_main\_\_\":

 app.run(host=\"0.0.0.0\", port=5000, debug=True)

[]{#anchor-17}Build the Application into a Docker Image

We have an application, but it needs to be packaged into a Docker image
before we can deploy it. We do that using a file called "Dockerfile" as
input to the Docker build process. A Dockerfile is a list of
instructions for the Docker "builder" component that tells it how to
construct the filesystem that will make up a container. Once that
container has all of the files needed, it will then save the file system
into an "image" that we can then deploy later. The concept is very
similar to how you might build, and share, virtual machine images.

**\$ cat web/Dockerfile**

FROM python:2.7-onbuild

EXPOSE 5000

CMD \[ \"python\", \"app.py\" \]

We won't go into the details of what the various Dockerfile commands
mean, but just know that the net result of the Docker "builder" running
these commands will be a new Docker image that contains our application
and the python runtime needed to execute our application.

If you do not have it yet, you can install docker from here:
[*https://docs.docker.com/engine/installation/*](https://docs.docker.com/engine/installation/)
. Before we run the Docker "build" command though we need to make sure
that we give our new image a name so we can refer to it later. For our
purposes we're going to call it "webapp" but we also need to give it a
"namespace" value so that when we upload it to a registry it will be
stored in a location that is just for us. Meaning, each user will have
their own "namespace" into which they can store images.

If you do not have a Docker ID account, you can set it up as follows:
[*https://docs.docker.com/docker-id/*](https://docs.docker.com/docker-id/)
. With that we can now build the image using the following command
(replace "\<namespace\>" with your Docker ID account name):

**\$ cd web**

**\$ docker build -t \<namespace\>/webapp .**

We can verify that it worked by looking at the list of Docker images
that are available to our local Docker engine:

**\$ docker images **

Notice the "webapp" image.

The image that we just built is only available to our local Docker
engine. In order for us to use it elsewhere, like in our IBM Cloud
hosted Kubernetes cluster, we need to upload it ("push" it) to the
registry:

**\$ docker login**

**\$ docker push \<namespace\>/webapp**

Now the Docker image is available for use outside of your machine.

[]{#anchor-18}Using IBM Cloud Container Registry (optional)

We can also push this image to the container registry available built in
to IBM Cloud. First, log in:

**\$ bx login**

Make sure you have container-registry plugin is installed by running the
following command:

**\$ bx plugin install container-registry -r Bluemix**

Then log in to the container registry

**\$ bx cr login **

If unsure of your namespace in the IBM Cloud container registry, check
with

**\$ bx cr namespace-list**

Tag built image with container registry tag

**\$ docker tag *****\<namespace\>*****/webapp
registry.ng.bluemix.net/*****\<namespace****\_ibmcloudcontainerregistry****\>*****/webapp**

Push to your namespace

**\$ docker push
registry.ng.bluemix.net/*****\<namespace\>*****/webapp**

Now we should list the image you just pushed to container registry

There are also commands that scan your image for vulnerabilities when
using BlueMix Container Registry

**\$ bx cr images**

Listing images\...

REPOSITORY NAMESPACE TAG DIGEST CREATED SIZE VULNERABILITY STATUS

registry.ng.bluemix.net/ossdemo/webapp ossdemo latest 34450444f2f4 3
weeks ago 275 MB Vulnerable

[]{#anchor-19}Deploying the Application

Now that we have both a Docker image (our application) and a Kubernetes
cluster available on the IBM Cloud, we can deploy the middle tier of our
application. In order to do that we need to tell Kubernetes how to
deploy the application. We do this using a yaml file that describes how
Kubernetes should construct our "pod" that is running our
container/image:

**\$ cat webpod.yaml**

apiVersion: \"v1\"

kind: Pod

metadata:

 name: web

 labels:

 app: demo

spec:

 containers:

 - name: web

 image: \<namespace\>/webapp

 ports:

 - containerPort: 5000

Let's discuss the contents of this file:

-   Kind: Pod, we are creating a Pod
-   We are adding one label, setting \`app\` to \`demo\`.
-   We have a whole separate section for the 'spec' of the pod
-   This spec contains the definition of what containers to run
-   We're running our previously built webapp container
-   This is a webserver, so we need to expose the port that is doing the
    serving.

Using kubectl we will now create the "web" Pod Object in Kubernetes. To
recall, this stores the pod definition into the underlying datastore.
The definition will be seen by several controllers in sequence who will
process it. The scheduler will schedule it, and the the chosen kubelet
will try to run the container.

**\$ kubectl create --f webpod.yaml**

pod \"web\" created

Let's see what the pod definition looks like now.

Eventually the pod enters a running state.

**\$ kubectl get pod web**

NAME READY STATUS RESTARTS AGE

web 1/1 Running 0 8s

The "web" Pod is now running

**\$ kubectl exec -it web bash**

**root@web:/usr/src/app\# **

Keep in mind that when the Pod is run it will look for "redis" service
to connect to which does not exist yet. Let's check the output of the
webapp.

**root@web:/usr/src/app\# curl 127.0.0.1:5000** \# responds with error
that it cannot find redis service

ConnectionError: Error -2 connecting to redis:6379. Name or service not
known

We cannot ping the web app from the node because the port 5000 is not
exposed (\`bc cs nodes\` to see worker ip). We need to expose "web" Pod
as a service in order to be able to reach this service on the Node.

Let us expose the web app as a service at port 80

[]{#anchor-20}Exposing our Application

Once the Container is tested, we need to expose it externally to the
cluster. To do that, we will create a Kubernetes Service. The Service
will give us a stable reference point to access the underlying pod.

**\$ cat websvc.yaml**

apiVersion: v1

kind: Service

metadata:

 name: web

 labels:

 app: demo

spec:

 selector:

 app: demo

 type: NodePort

 ports:

 - port: 5000

 nodePort: 31000

**\$ kubectl create -f websvc.yaml**

service \"web\" created

**\$ kubectl get svc**

NAME CLUSTER-IP EXTERNAL-IP PORT(S) AGE

web 10.10.10.70 \<nodes\> 5000:31000/TCP 3m

Note : The service is listening on the port 30951, a random port on the
node. Once we know the ip of the node we should be able to ping the
service. Let's get the name by looking at the details of the cluster in
the container service.

**\$ bx cs workers \<your cluster name\>**

OK

ID Public IP Private IP Machine Type State Status Version

kube-hou02-pa1e3ee39f549640aebea69a444f51fe55-w1 173.193.99.136
10.76.194.30 free normal Ready 1.5.6\_1500\*

**\$ curl 173.193.99.136:30951**

**\...**

"ConnectionError: Error -2 connecting to redis:6379. Name or service not
known.\"

\...

Should still show that redis is not available.

[]{#anchor-21}Service Ports

•**ClusterIP**: Exposes the service on a cluster-internal IP. Choosing
this value makes the service only reachable from within the cluster.
This is the default ServiceType

•**NodePort**: Exposes the service on each Node's IP at a static port
(the NodePort). A ClusterIP service, to which the NodePort service will
route, is automatically created. You'll be able to contact the NodePort
service, from outside the cluster, by requesting
\<NodeIP\>:\<NodePort\>.

•**LoadBalancer**: Exposes the service externally using a cloud
provider's load balancer. NodePort and ClusterIP services, to which the
external load balancer will route, are automatically created.

[]{#anchor-22}Deploy the Database

We are now ready to create the backend database for the 3-Tier
application. Our backend is redis pod that will store the number of
times a web page is requested, redis will just keep a counter that the
web server will query tevery time we access the page.

**\$ cat dbpod.yaml**

apiVersion: \"v1\"

kind: Pod =\> kind of resource is "pod"

metadata:

 name: redis =\> resource name "redis"

 labels:

 name: redis

 app: tutorial

spec: =\> spec usually has one container but allows multiple

 containers:

 - name: redis

 image: redis:latest =\> use the docker image "redis:latest"

 ports:

 - containerPort: 6379 =\> redis server listening on port 6379

 protocol: TCP

Let us now test redis pod.

List if any pods running, we should see your web pod running.

**\$ kubectl get pods**

NAME READY STATUS RESTARTS AGE

web 1/1 Running 0 8s

Now create the "redis" Pod

**\$ kubectl create --f dbpod.yaml**

pod \"redis\" created

Listing pods again will show both web and redis pods runnning.

**\$ kubectl get pods**

NAME READY STATUS RESTARTS AGE

web 1/1 Running 0 8m

redis 1/1 Running 0 14s

We can also get more details using the following command which shows the
port redis is listening on. We can detect that port is not exposed.

**\$ kubectl describe pods**

Let us test redis Pod alone.

**\$ kubectl exec -it redis bash**

**\$ redis-cli ping**

PONG

**\$ redis-cli**

127.0.0.1:6379\> set mykey test-only

OK

127.0.0.1:6379\> get mykey

\"test-only\"

127.0.0.1:6379\>

[]{#anchor-23}

[]{#anchor-24}

[]{#anchor-25}

[]{#anchor-26}Converting the Database into a Service

Our web application still cannot find redis as it is not exposed in the
cluster because the redis service needs to expose itself with a dns
entry reachable in the cluster.

**\$ curl 173.193.99.136:30951 **

Let us expose the redis service within the cluster so that web pod can
reach to it

**\$ cat dbsvc.yaml**

apiVersion: v1

kind: Service =\> exposed redis as a cluster service

metadata:

 name: redis

 labels:

 name: redis

 app: demo

spec:

 ports:

 - port: 6379 =\> expose redis at port 6379 in the cluster

 name: redis

 targetPort: 6379

 selector:

 name: redis

 app: demo

Now let's deploy it:

**\$ kubectl create -f dbsvc.yml**

service \"redis\" created

And, verify that it worked:

**\$ kubectl get svc**

NAME CLUSTER-IP EXTERNAL-IP PORT(S) AGE

redis 10.10.10.144 \<none\> 6379/TCP 42s

web 10.10.10.70 \<nodes\> 80:30951/TCP 9m

Notice the "PORT(S)" column shows that "redis" is listening on port 6379
at the cluster level, while "web" is listening on port 80. However, the
":30951" for "web" indicates that Kubernetes has also mapped port 80 to
30951 on the node. This means that sending a request to the node
directly, at that port, should get routed to the "web" container:

**\$ curl 173.193.99.136:30951** \# now the web svc can find redis.

Hello Container World from web! I have been seen 1 times.

[]{#anchor-27}Cleaning Up

Let us delete the web pod:

**\$ kubectl delete pod web**

pod \"web\" deleted

pod \"redis\" deleted

**\$ kubectl delete svc redis web**

service \"redis\" deleted

service \"web\" deleted

We're leaving the web Service around, as we're using it in the next
section. We'll also use the same \`redis\` that we've already
provisioned.

[]{#anchor-28}

[]{#anchor-29}

[]{#anchor-30}

[]{#anchor-31}Small Break

[]{#anchor-32}Scaling

Remember when we talked about the scalability of kube earlier? So far we
haven't seen much that allows us to scale. It would be difficult to
scale up if we had to make and track thousands of copies of the same pod
yaml.

Kubernetes has other resources built-in specifically for the purposes of
scaling. These other resources take a pod definition and use it as a
template.

The new resource we are using here is called a "Deployment". The
following yaml show an example where we define a single container, but
ask for it to be scaled up to "2" replicas - see line 6 in bold:

**\$ cat webdep.yaml**

apiVersion: extensions/v1beta1

kind: Deployment

metadata:

 name: web

spec:

** replicas: 2**

 template:

 metadata:

 labels:

 app: web

 version: v1

 spec:

 containers:

 - name: web

 image: registry.ng.bluemix.net/ossdemo/webapp

 imagePullPolicy: IfNotPresent

 ports:

 - containerPort: 5000

Notice that the "spec" section looks very similar to how we defined our
pods in the previous steps. The "Deployment resource is meant to simply
be an extension to what we already know.

Now, let's deploy it:

**\$ kubectl create -f webdep.yaml **

deployment \"web\" created

And check to see if it worked:

**\$ kubectl get deploy**

NAME DESIRED CURRENT UP-TO-DATE AVAILABLE AGE

web 2 2 2 2 8s

Since a Deployment uses pods, we can also check on the status of each
individual pods as well, just like we've done in previous steps:

**\$ kubectl get pods**

NAME READY STATUS RESTARTS AGE

redis 1/1 Running 0 11h

web-4262754926-nd6fb 1/1 Running 0 5m

web-4262754926-z2bw8 1/1 Running 0 5m

Now that the app is deployed, we can access it over the same service
that was already deployed. While we access it, it should print out a
different hostname on each refresh.

We have two copies of the pod, let's make more!

First, let's edit webdep.yaml and change the number of replicas. We only
have a single node, so let's not get crazy. We should be able to support
another two instances, so let's change the number of replicas to 4.

Now let's post the edited version by using apply:

**\$ kubectl apply -f webdep.yaml**

Accessing the service again, we should see two more names when
refreshing.

To run the web application again we need to expose the deployment.

**\$ kubectl expose deployment web \--type=LoadBalancer**

service \"web\" exposed

You can now reach the web service again using the curl command. Let us
first check the port that is exposed.

**\$ kubectl get svc**

web 10.10.10.82 \<pending\> 5000:31630/TCP 6s

**\$ curl 173.193.99.136:31630**

Hello Container World from web-829031562-jsm60! I have been seen 1
times.

**\$ curl 173.193.99.136:31630**

Hello Container World from web-829031562-k9r38! I have been seen 2
times.

Each call is handled by one of the instances of the web service we
created.

[]{#anchor-33}Further Reading and Courses

We offer more advanced courses on Kubernetes for further enhancing your
capability to build Enterprise grade applications on BlueMix.
